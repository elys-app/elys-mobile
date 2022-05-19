

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
 exports.handler = async (event) => {
    console.log(`EVENT: ${JSON.stringify(event)}`);

    const timeToWarn = 15; // minutes
    const timeToSend = 29; // minutes
  
    const rightNow = new Date();
    const submittedString = event.timeSubmitted.toISOString().substring(0,19) + 'Z';
    const submitted = new Date(submittedString);
    const difference = (rightNow - submitted)/(60*1000);

    console.log(submittedString);
    console.log(submitted);
    console.log(difference);
  
    if ((rightNow - submitted) > timeToSend) {
      return ({
        action: 'send-text',
        event: event
      });
    }
    else if ((rightNow - submitted) > timeToWarn) {
        return ({
            action: 'send-warning',
            event: event
        })
    }
    else {
        return ({action: 'none', event: event});
    }
  };
  
