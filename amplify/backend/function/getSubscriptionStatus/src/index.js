const stripe = require('stripe')('sk_test_51JG9pzFbE7WYTcrpDa1nRBtHDzQ9AkmkOZHTy67QoHQaHcWKXmr5pwSIvdlpBsKHcN5ocdYicGgItq0Wj8uUMAnG00fXn7Wgjo');

exports.handler = async (event) => {

  const subscription = await stripe.subscriptions.retrieve(
    event.arguments.subscriptionId,
  );

  if (subscription) {
    return {
      'customerStatus': subscription.status
    };
  } else {
    return {
      'status': 'hold'
    };
  }
};
