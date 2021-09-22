const stripe = require('stripe')('sk_test_51JG9pzFbE7WYTcrpDa1nRBtHDzQ9AkmkOZHTy67QoHQaHcWKXmr5pwSIvdlpBsKHcN5ocdYicGgItq0Wj8uUMAnG00fXn7Wgjo');

exports.handler = async (event) => {
  await stripe.paymentMethods.attach(
    event.arguments.paymentMethodId, {
      customer: event.arguments.customerId
    }
  );

  const result = await stripe.customers.update(
    event.arguments.customerId, {
      invoice_settings: {
        default_payment_method: event.arguments.paymentMethodId
      }
    },
  );
  return result;
};
