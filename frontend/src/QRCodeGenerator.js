import React, { useState } from 'react';

const QRCodeGenerator = () => {
    const [amount, setAmount] = useState('');
    const [currency, setCurrency] = useState('USD');
    const [paymentReference, setPaymentReference] = useState('');
    const [qrCode, setQrCode] = useState(null);

    const handleSubmit = async (e) => {
        e.preventDefault();

        const response = await fetch(`https://your-api-gateway-url/qr?amount=${amount}&currency=${currency}&paymentReference=${paymentReference}`);
        const data = await response.json();

        if (data.qrCode) {
            setQrCode(data.qrCode);
        }
    };

    return (
        <div className="form-container">
            <form onSubmit={handleSubmit}>
                <label>
                    Amount:
                    <input type="number" value={amount} onChange={(e) => setAmount(e.target.value)} required />
                </label>
                <label>
                    Currency:
                    <select value={currency} onChange={(e) => setCurrency(e.target.value)}>
                        <option value="USD">USD</option>
                        <option value="EUR">EUR</option>
                        <option value="JPY">JPY</option>
                    </select>
                </label>
                <label>
                    Payment Reference:
                    <input type="text" value={paymentReference} onChange={(e) => setPaymentReference(e.target.value)} required />
                </label>
                <button type="submit">Generate QR Code</button>
            </form>
            {qrCode && <img src={qrCode} alt="Payment QR Code" />}
        </div>
    );
};

export default QRCodeGenerator;
