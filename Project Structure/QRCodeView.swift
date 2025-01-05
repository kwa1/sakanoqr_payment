import SwiftUI

struct QRCodeView: View {
    @StateObject private var viewModel = QRCodeViewModel()

    var body: some View {
        VStack(spacing: 20) {
            Text("Sakano Payment QR Code Generator")
                .font(.title)
                .multilineTextAlignment(.center)
                .padding()

            Form {
                TextField("Amount", text: $viewModel.amount)
                    .keyboardType(.decimalPad)

                Picker("Currency", selection: $viewModel.currency) {
                    Text("USD").tag("USD")
                    Text("EUR").tag("EUR")
                    Text("JPY").tag("JPY")
                }
                .pickerStyle(SegmentedPickerStyle())

                TextField("Payment Reference", text: $viewModel.paymentReference)
            }
            .padding()

            if let qrCodeURL = viewModel.qrCodeURL {
                AsyncImage(url: qrCodeURL) { image in
                    image.resizable()
                        .scaledToFit()
                        .frame(maxWidth: 300, maxHeight: 300)
                } placeholder: {
                    ProgressView()
                }
            }

            Button("Generate QR Code") {
                viewModel.fetchQRCode()
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
        .padding()
    }
}
