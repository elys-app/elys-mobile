const AWS = require('aws-sdk');
const {
  getMaxListeners
} = require('process');
const SES = new AWS.SES({
  region: 'us-east-1'
});

exports.handler = async (event) => {
  var params = {
    Destination: {
      ToAddresses: event.arguments.toAddresses
    },
    Message: {
      Body: {
        Text: {
          Data: 'Some text in the email'
        },
      },
      Subject: {
        Data: event.arguments.eventText
      },
    },
    Source: "admin@elys-app.net",
  };
  return SES.sendEmail(params).promise();
};
