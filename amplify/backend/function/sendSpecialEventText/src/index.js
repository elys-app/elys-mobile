const aws = require("aws-sdk");
const sns = new aws.SNS();

const {
  getMaxListeners
} = require('process');

const { getSignedUrl } = require("@aws-sdk/s3-request-presigner");
const { S3Client, GetObjectCommand } = require("@aws-sdk/client-s3");

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
  const duration = 900;

  const _region = event.event.region.S;
  const _bucket = event.event.bucket.S;
  const _fileKey = event.event.fileKey.S;

  const client = new S3Client({region: _region});
  const command = new GetObjectCommand({Key: _fileKey, Bucket: _bucket});
  const _url = await getSignedUrl(client, command, { expiresIn: 7200 });
  
  console.log(_url);
  
  const messageText = 'A Message from Elys for ' + event.event.emergencyName.S + ' ' + _url;
  const phoneNumber = event.event.emergencyNumber.S;

  var snsParams = {
    Message: messageText,
    PhoneNumber: phoneNumber,
  };

  // Handle promise's fulfilled/rejected states

  await sns.publish(snsParams).promise().then(
    function (data) {
      console.log("MessageID is " + data.MessageId);
    }).catch(
    function (err) {
      console.error(err, err.stack);
    });

  return event;
};