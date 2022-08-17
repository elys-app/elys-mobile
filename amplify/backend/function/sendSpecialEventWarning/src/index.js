const aws = require("aws-sdk");
const s3 = new aws.S3();
const ses = new aws.SES({
  region: 'us-east-1'
});

const {
  getMaxListeners
} = require('process');


/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
  const year = event.event.timeSubmitted.S.slice(0,4);
  const month = event.event.timeSubmitted.S.slice(5,7);
  const day = event.event.timeSubmitted.S.slice(8,10);
  const time = event.event.timeSubmitted.S.slice(11,16);

  const formattedTime = time + ' on ' + month + '/' + day + '/' + year;

  const emailDetails = {
    Destination: {
      ToAddresses: [event.event.ownEmail.S]
    },
    Source: "admin@elys-app.net",
    Template: "WarningTemplate",
    TemplateData: "{ \"time\": \"" + formattedTime + "\"}"
  };
  await ses.sendTemplatedEmail(emailDetails).promise();
  return event;
};
 