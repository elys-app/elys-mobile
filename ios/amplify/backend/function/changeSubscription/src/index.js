const stripe = require('stripe')('sk_test_51JG9pzFbE7WYTcrpDa1nRBtHDzQ9AkmkOZHTy67QoHQaHcWKXmr5pwSIvdlpBsKHcN5ocdYicGgItq0Wj8uUMAnG00fXn7Wgjo');

exports.handler = async (event) => {
    const results = [];

    try {
        const subscription = await stripe.subscriptions.retrieve(event.arguments.subscriptionId);
        stripe.subscriptions.update(event.arguments.subscriptionId, {
            cancel_at_period_end: false,
            proration_behavior: 'create_prorations',
            items: [{
                id: subscription.items.data[0].id,
                price: event.arguments.newPriceId,
            }]
        });
        return 'OK';
    }
    catch {
        throw error("Couldn't Find the Subscription");
    }
};
