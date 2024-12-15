import React from 'react';
import QRCodeGenerator from './QRCodeGenerator';
import './styles.css';

function App() {
    return (
        <div className="app-container">
            <h1>Sakano Payment QR Code Generator</h1>
            <QRCodeGenerator />
        </div>
    );
}

export default App;
