const stripe = require('stripe')('sk_test_51JG9pzFbE7WYTcrpDa1nRBtHDzQ9AkmkOZHTy67QoHQaHcWKXmr5pwSIvdlpBsKHcN5ocdYicGgItq0Wj8uUMAnG00fXn7Wgjo');

exports.handler = async (event) => {
    const results = [];
    
    const response = await stripe.invoices.list({
        customer: event.arguments.customerId,
        limit: 3,
      });

    for (let invoice of response.data) {
        let item = {
            date:  new Date(invoice.created * 1000 ),
            amount_paid: invoice.amount_paid / 100,
            invoice_number: invoice.number
        };
        results.push(item);
    }
    return results;
};
