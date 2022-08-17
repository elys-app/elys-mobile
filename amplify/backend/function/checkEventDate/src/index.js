/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */

 exports.handler = async (event) => {
    const monthNames = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];

    const rightNow = new Date();

    const eventDate = event.eventDate.S
    const eventMonth = event.eventMonth.S
    const eventYear = event.eventYear.S

    if (eventYear === rightNow.getFullYear().toString()) {
        if (eventMonth === monthNames[rightNow.getMonth()]) {
            if (eventDate === rightNow.getDate().toString()) {
                return ({
                    action: 'send-event',
                    event: event
                });
            }
            else {
                return ({ action: 'none', event: event });
            }
        }
        else {
            return ({ action: 'none', event: event });
        }
    }
    else {
        return ({ action: 'none', event: event });
    }
};