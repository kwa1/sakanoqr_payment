#For macOS, you can reuse the same SwiftUI structure. Here's a macOS-specific entry point:

swift
Copy code
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
