

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
 exports.handler = async (event) => {
  const timeToWarn = 5; // minutes
  const timeToSend = 9; // minutes
 
  const rightNow = new Date();
  
  const trimmedTimeString = event.timeSubmitted.S.substring(0,19) + 'Z'; // remove decimal seconds
  const submittedTimeString = new Date(trimmedTimeString);

  const difference = (rightNow - submittedTimeString)/(60*1000); // convert difference to minutes

  if (difference > timeToSend) {
    return ({
      action: 'send-text',
      event: event
    });
  }
  else if (difference > timeToWarn) {
      return ({
          action: 'send-warning',
          event: event
      })
  }
  else {
      return ({action: 'none', event: event});
  }
};

