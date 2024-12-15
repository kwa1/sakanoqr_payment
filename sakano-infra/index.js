const QRCode = require('qrcode');

exports.handler = async (event) => {
    try {
        const queryParams = event.queryStringParameters;

        if (!queryParams || !queryParams.amount || !queryParams.currency || !queryParams.paymentReference) {
            return {
                statusCode: 400,
                body: JSON.stringify({ error: 'Missing required parameters: amount, currency, or paymentReference' }),
            };
        }

        const paymentUrl = `https://sakano-payments.com/pay?amount=${queryParams.amount}&currency=${queryParams.currency}&paymentReference=${queryParams.paymentReference}`;
        const qrCode = await QRCode.toDataURL(paymentUrl);

        return {
            statusCode: 200,
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ paymentUrl, qrCode }),
        };
    } catch (error) {
        console.error(error);
        return {
            statusCode: 500,
            body: JSON.stringify({ error: 'Internal Server Error' }),
        };
    }
};
