const stripe = require('stripe')('sk_test_51JG9pzFbE7WYTcrpDa1nRBtHDzQ9AkmkOZHTy67QoHQaHcWKXmr5pwSIvdlpBsKHcN5ocdYicGgItq0Wj8uUMAnG00fXn7Wgjo');

exports.handler = async (event) => {
    try {
        const subscription = await stripe.subscriptions.retrieve(
            event.arguments.subscriptionId,
        );
        return subscription.items.data[0].price.id;
    }
    catch (e) {
        return 'none';
    }
};
