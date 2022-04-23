const AWS = require('aws-sdk');
const {
  getMaxListeners
} = require('process');
const SES = new AWS.SES({
  region: 'us-east-1'
});

exports.handler = async (event) => {

  const emailDetails = {
    Destination: {
      ToAddresses: event.arguments.toAddresses
    },
    Source: "admin@elys-app.net",
    Template: "DesigneeTemplate",
    TemplateData: "{ \"designee_name\": \"" + event.arguments.designeeName + "\", \"client_name\": \"" + event.arguments.clientName + "\"}"
  };
  return SES.sendTemplatedEmail(emailDetails).promise();
};
