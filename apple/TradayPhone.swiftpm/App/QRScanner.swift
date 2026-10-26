// Source code is private. This file shows only its types and signatures.

import SwiftUI
import Vision
import VisionKit

/// The camera, looking for the pairing QR code your Mac shows in traday → Settings → Phone.
/// Apple's live-text scanner (iOS 16, iPhone XS or newer); it calls `found` once with the code's text.
@MainActor
struct QRScanner: UIViewControllerRepresentable {
    let found: (String) -> Void

    /// False on the Simulator and older iPhones: then pasting the link is the way.
    static var available: Bool { /* private */ }

    func makeUIViewController(context: Context) -> DataScannerViewController { /* private */ }

    func updateUIViewController(_ scanner: DataScannerViewController, context: Context) { /* private */ }

    static func dismantleUIViewController(_ scanner: DataScannerViewController, coordinator: Coordinator) { /* private */ }

    func makeCoordinator() -> Coordinator { /* private */ }

    @MainActor
    final class Coordinator: NSObject, DataScannerViewControllerDelegate {
        private let found: (String) -> Void
        private var done

        init(found: @escaping (String) -> Void) { /* private */ }

        func dataScanner(_ dataScanner: DataScannerViewController, didAdd addedItems: [RecognizedItem],
                         allItems: [RecognizedItem]) { /* private */ }
    }
}

/// The scanner full screen, with a way out.
@MainActor
struct ScanSheet: View {
    let found: (String) -> Void
    let cancel: () -> Void

    var body: some View { /* private */ }
}
