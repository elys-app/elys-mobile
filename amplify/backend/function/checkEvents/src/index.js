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

// const AWS = require('aws-sdk');
const {
  getMaxListeners
} = require('process');

// const SES = new AWS.SES({
//   region: 'us-east-1'
// });

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */

async function getS3File(bucket, key) {
  return new Promise(function (resolve, reject) {
    s3.getObject({
        Bucket: bucket,
        Key: key
      },
      function (err, data) {
        if (err) return reject(err);
        else return resolve(data);
      }
    );
  })
}

exports.handler = async (event) => {

  // Get the attachement

  const fileData = await getS3File(
    "elysonline361ff3e65f004dbbaf0eaa5afa9ce9ec103619-test",
    "public/user-32-IMG_0367.png"
  );

  var mailOptions = {
    from: "admin@elys-app.net",
    to: "admin@elys-app.net",
    subject: "This is Content From Elys!",
    html: `<p>The attachment is content that an Elys client sent to you.</p>`,
    attachments: [{
      filename: "public/user-32-IMG_0367.png",
      content: fileData.Body
    }]
  };

  // send email
  return transporter.sendMail(mailOptions)
    .then(results => {

      return {
        statusCode: 200,
        body: JSON.stringify({
          "API Success": results
        }, null),
        headers: {
          'Access-Control-Allow-Origin': '*',
        },
      };

    })
    .catch(error => {
      console.log("Error:", error);

      return {
        statusCode: 500,
        body: JSON.stringify({
          "API Error": error
        }, null),
        headers: {
          'Access-Control-Allow-Origin': '*',
        },
      };

    })
};
