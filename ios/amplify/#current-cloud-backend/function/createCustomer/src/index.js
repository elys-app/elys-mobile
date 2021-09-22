const stripe = require("stripe")("sk_test_51JG9pzFbE7WYTcrpDa1nRBtHDzQ9AkmkOZHTy67QoHQaHcWKXmr5pwSIvdlpBsKHcN5ocdYicGgItq0Wj8uUMAnG00fXn7Wgjo");

exports.handler = async (event) => {

  const newCustomer = await stripe.customers.create({
    email: event.arguments.email,
  });
  return newCustomer.id;
}
