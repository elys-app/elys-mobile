const stripe = require('stripe')('sk_test_51JG9pzFbE7WYTcrpDa1nRBtHDzQ9AkmkOZHTy67QoHQaHcWKXmr5pwSIvdlpBsKHcN5ocdYicGgItq0Wj8uUMAnG00fXn7Wgjo');

exports.handler = async (event) => {
    try {
        const invoice = await stripe.invoices.retrieveUpcoming({
            customer: event.arguments.customerId,
        });
        let item = {
            date: new Date(invoice.created * 1000),
            amount_paid: invoice.amount_due / 100,
            invoice_number: 'NA'
        };
        return item;
    }
    catch {
        return {
            date: 'NA',
            amount_paid: 'NA',
            invoice_number: 'NA'
        };
    }
};
