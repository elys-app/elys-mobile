const stripe = require('stripe')('sk_test_51JG9pzFbE7WYTcrpDa1nRBtHDzQ9AkmkOZHTy67QoHQaHcWKXmr5pwSIvdlpBsKHcN5ocdYicGgItq0Wj8uUMAnG00fXn7Wgjo');

exports.handler = async (event) => {
    try {
        const subscription = await stripe.subscriptions.retrieve(
            event.arguments.subscriptionId,
        );
        let priceId = subscription.items.data[0].price.id;
        const { product } = await stripe.prices.retrieve(
            priceId
        );
        console.log(product);
        const { name } = await stripe.products.retrieve(
            product
        )
        return name;
    }
    catch (e) {
        return 'No product found';
    }
};
