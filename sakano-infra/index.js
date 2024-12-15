const QRCode = require('qrcode');
const axios = require('axios');

// Environment variables for Flutterwave API
const FLW_SECRET_KEY = process.env.FLW_SECRET_KEY;
const FLW_BASE_URL = 'https://api.flutterwave.com/v3';

// Allowed query parameters
const paramKeys = ['amount', 'currency', 'customer_email', 'customer_name', 'mobile_money', 'sid', 'locale'];

exports.handler = async (event, context, callback) => {
  try {
    const queryParams = event.queryStringParameters;
    if (!queryParams) {
      return callback(null, {
        statusCode: 400,
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ error: 'No query parameters provided' }),
      });
    }

    // Handle QR code generation
    if (event.path.includes('.png') || event.path.includes('.svg')) {
      const size = Math.min(Math.max(queryParams.size || 300, 100), 1000);
      const redirectUrl = `https://${event.headers.Host}/payment?${Object.entries(queryParams)
        .map(([key, value]) => `${key}=${encodeURIComponent(value)}`)
        .join('&')}`;

      if (event.path.includes('.png')) {
        const png = await QRCode.toDataURL(redirectUrl, { width: size });
        return callback(null, {
          statusCode: 200,
          headers: { 'Content-Type': 'image/png' },
          body: Buffer.from(png.split(',')[1], 'base64').toString('base64'),
          isBase64Encoded: true,
        });
      } else if (event.path.includes('.svg')) {
        const svg = await QRCode.toString(redirectUrl, { type: 'svg', width: size });
        return callback(null, {
          statusCode: 200,
          headers: { 'Content-Type': 'image/svg+xml' },
          body: svg,
        });
      }
    }

    // Handle payment initiation
    if (event.path.includes('/payment')) {
      const { amount, currency = 'GHS', customer_email, customer_name, mobile_money } = queryParams;

      if (!amount || !customer_email || !customer_name) {
        return callback(null, {
          statusCode: 400,
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ error: 'Missing required payment parameters' }),
        });
      }

      // Payment request payload
      const payload = {
        tx_ref: `sakano-${Date.now()}`,
        amount,
        currency,
        payment_type: mobile_money ? 'mobilemoneygh' : 'card',
        redirect_url: `https://${event.headers.Host}/payment/confirmation`,
        customer: {
          email: customer_email,
          name: customer_name,
        },
        customizations: {
          title: 'Sakano Payment',
          description: 'Payment for goods/services',
          logo: 'https://example.com/logo.png', // Add your logo URL
        },
      };

      // Call Flutterwave API
      const response = await axios.post(`${FLW_BASE_URL}/payments`, payload, {
        headers: {
          Authorization: `Bearer ${FLW_SECRET_KEY}`,
          'Content-Type': 'application/json',
        },
      });

      // Respond with payment link
      return callback(null, {
        statusCode: 200,
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          payment_link: response.data.data.link,
          tx_ref: payload.tx_ref,
        }),
      });
    }

    // Handle invalid routes
    return callback(null, {
      statusCode: 404,
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ error: 'Invalid request' }),
    });
  } catch (error) {
    return callback(null, {
      statusCode: 500,
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ error: error.message }),
    });
  }
};
