const stripe = require("stripe")("sk_test_51JG9pzFbE7WYTcrpDa1nRBtHDzQ9AkmkOZHTy67QoHQaHcWKXmr5pwSIvdlpBsKHcN5ocdYicGgItq0Wj8uUMAnG00fXn7Wgjo");

exports.handler = async (event) => {

  const newSubscription = await stripe.subscriptions.create({
    customer: event.arguments.customerId,
    items: [{
      price: event.arguments.priceId
    }],
    payment_behavior: 'default_incomplete',
    expand: ['latest_invoice.payment_intent']
  });
  return {
    subscriptionId: newSubscription.id,
    clientSecret: newSubscription.latest_invoice.payment_intent.client_secret
  }
}
