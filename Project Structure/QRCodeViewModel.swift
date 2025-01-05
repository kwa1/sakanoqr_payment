import Foundation
import Combine

class QRCodeViewModel: ObservableObject {
    @Published var amount: String = ""
    @Published var currency: String = "USD"
    @Published var paymentReference: String = ""
    @Published var qrCodeURL: URL?

    private var cancellables = Set<AnyCancellable>()

    func fetchQRCode() {
        guard let url = URL(string: "https://your-api-gateway-url/qr?amount=\(amount)&currency=\(currency)&paymentReference=\(paymentReference)") else { return }

        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: QRResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error fetching QR Code: \(error)")
                }
            }, receiveValue: { [weak self] response in
                self?.qrCodeURL = URL(string: response.qrCode)
            })
            .store(in: &cancellables)
    }
}

struct QRResponse: Decodable {
    let qrCode: String
}
