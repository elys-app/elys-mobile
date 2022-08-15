const stripe = require("stripe")("sk_test_51JG9pzFbE7WYTcrpDa1nRBtHDzQ9AkmkOZHTy67QoHQaHcWKXmr5pwSIvdlpBsKHcN5ocdYicGgItq0Wj8uUMAnG00fXn7Wgjo");

exports.handler = async (event) => {
  await stripe.paymentMethods.attach(event.arguments.paymentMethodId, {
    customer: event.arguments.customerId,
  });

  // Change the default invoice settings on the customer to the new payment method
  
  await stripe.customers.update(
    event.arguments.customerId,
    {
      invoice_settings: {
        default_payment_method: event.arguments.paymentMethodId,
      },
    });

  // Create the subscription

  if (event.arguments.couponId !== '') {
    const newSubscription = await stripe.subscriptions.create({
      customer: event.arguments.customerId,
      items: [{
        price: event.arguments.priceId
      }],
      coupon: event.arguments.couponId,
      expand: ['latest_invoice.payment_intent'],
      proration_behavior: 'none',
      off_session: true,
      collection_method: 'charge_automatically'
    });
    return {
      subscriptionId: newSubscription.id,
    }
  }
  else {
    const newSubscription = await stripe.subscriptions.create({
      customer: event.arguments.customerId,
      items: [{
        price: event.arguments.priceId
      }],
      expand: ['latest_invoice.payment_intent'],
      off_session: true,
      collection_method: 'charge_automatically'
    });
    return {
      subscriptionId: newSubscription.id,
    }
  }
}