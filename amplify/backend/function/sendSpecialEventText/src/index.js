const aws = require("aws-sdk");
const s3 = new aws.S3();
const ses = new aws.SES({
  region: 'us-east-1'
});
const sns = new aws.SNS();
const docClient = new aws.DynamoDB.DocumentClient();

const {
  getMaxListeners
} = require('process');


/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
  const messageText = 'A Message from Elys for ' + event.emergencyName.S;
  const phoneNumber = event.emergencyNumber.S;

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
