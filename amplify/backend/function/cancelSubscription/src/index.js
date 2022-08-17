
const stripe = require("stripe")("sk_test_51JG9pzFbE7WYTcrpDa1nRBtHDzQ9AkmkOZHTy67QoHQaHcWKXmr5pwSIvdlpBsKHcN5ocdYicGgItq0Wj8uUMAnG00fXn7Wgjo");

exports.handler = async (event) => {

  const subscriptionId = event.arguments.subscriptionId;

  try {
    const subscription = await stripe.subscriptions.update(subscriptionId,
      {cancel_at_period_end: true}
    );
    return subscription.current_period_end
  }
  catch (err) {
    console.log(JSON.stringify(err));
    return {
      cancelDate: 'NA'
    }
  }
}
