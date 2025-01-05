#macOS Files
import SwiftUI

@main
struct QRCodeMacApp: App {
    var body: some Scene {
        WindowGroup {
            QRCodeView()
                .frame(minWidth: 400, minHeight: 600)
        }
    }
}
