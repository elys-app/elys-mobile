/* Amplify Params - DO NOT EDIT
	API_ELYSONLINE_EVENTTABLE_ARN
	API_ELYSONLINE_EVENTTABLE_NAME
	API_ELYSONLINE_GRAPHQLAPIENDPOINTOUTPUT
	API_ELYSONLINE_GRAPHQLAPIIDOUTPUT
	ENV
	REGION
	STORAGE_S3ELYSCONTENT_BUCKETNAME
Amplify Params - DO NOT EDIT */

const aws = require("aws-sdk");
const s3 = new aws.S3();
const ses = new aws.SES({
  region: 'us-east-1'
});
const nodemailer = require("nodemailer");
const transporter = nodemailer.createTransport({
  SES: ses
});

const { getSignedUrl } = require("@aws-sdk/s3-request-presigner");
const { S3Client, GetObjectCommand } = require("@aws-sdk/client-s3");

const {
  getMaxListeners
} = require('process');

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */

exports.handler = async (event) => {
  const duration = 14400;

  const _region = event[0][0].contentInfo.region.S;
  const _bucket = event[0][0].contentInfo.bucket.S;
  const _fileKey = event[0][0].contentInfo.fileKey.S;

  const client = new S3Client({ region: _region });
  const command = new GetObjectCommand({ Key:'public/' + _fileKey, Bucket: _bucket });
  const _url = await getSignedUrl(client, command, { expiresIn: duration });

  var mailOptions = {
    from: "admin@elys-app.net",
    to: event[0][1].contactInfo.email.S,
    subject: "This is Content From Elys!",
    html: `<p>This link contains content that an Elys Legacy Management subscriber sent to you: \n` + _url + `<p>`
  };

  // send email
  return transporter.sendMail(mailOptions)
    .then(results => {
      return {
        statusCode: 200,
        body: JSON.stringify({
          "messageId": results.messageId
        }, null),
        headers: {
          'Access-Control-Allow-Origin': '*',
        },
      };

    })
    .catch(error => {
      throw new Error({id: event[1].id.S});
    })
};
