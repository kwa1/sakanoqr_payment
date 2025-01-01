#Create a basic unit test to verify the functionality of the QRCodeViewModel (API call).
import XCTest
@testable import YourAppName

class QRCodeViewModelTests: XCTestCase {

    var viewModel: QRCodeViewModel!

    override func setUp() {
        super.setUp()
        viewModel = QRCodeViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testQRCodeFetchSuccess() {
        // Given
        let expectation = XCTestExpectation(description: "QR Code fetch succeeds")

        viewModel.amount = "100"
        viewModel.currency = "USD"
        viewModel.paymentReference = "REF12345"

        // When
        viewModel.fetchQRCode()

        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertNotNil(self.viewModel.qrCodeURL, "QR code URL should not be nil")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5)
    }

    func testQRCodeFetchFailure() {
        // Given
        let expectation = XCTestExpectation(description: "QR Code fetch fails")

        viewModel.amount = "100"
        viewModel.currency = "USD"
        viewModel.paymentReference = "INVALID_REF"

        // When
        viewModel.fetchQRCode()

        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertNil(self.viewModel.qrCodeURL, "QR code URL should be nil")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5)
    }
}
