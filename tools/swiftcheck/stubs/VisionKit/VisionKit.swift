// Source code is private. This file shows only its types and signatures.

@_exported import UIKit
import Vision

@MainActor
public class DataScannerViewController: UIViewController {
    public struct RecognizedDataType: Hashable {
        public static func barcode(symbologies: [VNBarcodeSymbology] = []) -> RecognizedDataType { /* private */ }
    }

    public enum QualityLevel { case balanced, fast, accurate }

    public init(recognizedDataTypes: Set<RecognizedDataType>, qualityLevel: QualityLevel = .balanced,
                recognizesMultipleItems: Bool = false, isHighFrameRateTrackingEnabled: Bool = true,
                isPinchToZoomEnabled: Bool = true, isGuidanceEnabled: Bool = true, isHighlightingEnabled: Bool = false) { /* private */ }

    public weak var delegate: DataScannerViewControllerDelegate?
    public var isScanning: Bool { /* private */ }
    public func startScanning() throws { /* private */ }
    public func stopScanning() { /* private */ }
    public class var isSupported: Bool { /* private */ }
    public class var isAvailable: Bool { /* private */ }
}

public enum RecognizedItem {
    public struct Text { public var transcript: String { /* private */ }}
    public struct Barcode { public var payloadStringValue: String? { /* private */ }}
    case text(Text)
    case barcode(Barcode)
}

@MainActor
public protocol DataScannerViewControllerDelegate: AnyObject {
    func dataScanner(_ dataScanner: DataScannerViewController, didAdd addedItems: [RecognizedItem], allItems: [RecognizedItem])
}

extension DataScannerViewControllerDelegate {
    public func dataScanner(_ dataScanner: DataScannerViewController, didAdd addedItems: [RecognizedItem], allItems: [RecognizedItem]) { /* private */ }
}
