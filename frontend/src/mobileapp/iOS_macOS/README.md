Sakano Payment QR Code Generator
A cross-platform QR code generator app that allows users to create payment QR codes based on a specified amount,
currency, and payment reference. This app is built using SwiftUI and Combine for iOS and macOS.

Features
Generate a QR code for payment using the API.
Choose between different currencies (USD, EUR, JPY).
Enter an amount and payment reference to create a unique QR code.
Responsive design for both iOS and macOS.
Requirements
Xcode 12.0 or higher
iOS 14.0+ or macOS 11.0+ (for SwiftUI compatibility)
Swift 5.0+
An active internet connection to fetch QR codes from the API.
Installation
Clone the Repository
First, clone the repository to your local machine:

bash
Copy code
git clone https://github.com/kwa1/sakanoqr_payment.git
cd sakanoqr_payment code-generator
Open the Project in Xcode
Open the .xcodeproj or .xcworkspace file in Xcode.
Ensure the project is set to your desired target (iOS or macOS).
API Configuration
Replace the placeholder URL https://your-api-gateway-url/qr with the actual URL of your backend API that generates QR codes.

In QRCodeViewModel.swift, update the URL:

swift
Copy code
guard let url = URL(string: "https://your-api-gateway-url/qr?amount=\(amount)&currency=\(currency)&paymentReference=\(paymentReference)") else { return }
Run the App
Select the desired simulator (iPhone or Mac) or a physical device.
Click the play button (or press Cmd + R) to build and run the app.
Usage
iOS
Launch the app on your iPhone or simulator.
Enter the payment details (amount, currency, and reference).
Click "Generate QR Code" to fetch and display the QR code.
macOS
Launch the app on your Mac.
Enter the payment details and click "Generate QR Code".
The QR code will appear in the window.
File Structure
graphql
Copy code
├── QRCodeApp.swift              # App entry point for iOS/macOS
├── QRCodeView.swift             # Main view displaying the form and QR code
├── QRCodeViewModel.swift        # ViewModel handling API requests and state
├── ContentView.swift            # macOS-specific view setup
├── QRCodeViewModelTests.swift   # Unit tests for the ViewModel
├── Assets.xcassets              # App assets (icons, images)
└── Info.plist                   # App configuration
Unit Testing
To run unit tests:

Open Xcode's Test Navigator (Cmd + 5).
Select the test file (QRCodeViewModelTests.swift).
Click the play button to run the tests.
The QRCodeViewModelTests.swift contains two basic tests:

testQRCodeFetchSuccess: Verifies that a valid QR code is returned from the API.
testQRCodeFetchFailure: Verifies that the QR code URL is nil if the API call fails.
License
This project is licensed under the MIT License - see the LICENSE file for details.

