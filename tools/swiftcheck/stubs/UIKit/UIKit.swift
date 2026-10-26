// Source code is private. This file shows only its types and signatures.

@_exported import Foundation

public final class UIPasteboard {
    public static let general
    public var string: String?
}

public enum UIKeyboardType: Int {
    case `default`, asciiCapable, numbersAndPunctuation, URL, numberPad, phonePad, namePhonePad, emailAddress, decimalPad
}

@MainActor
open class UIResponder: NSObject {}

@MainActor
open class UIViewController: UIResponder {
    public override init() { /* private */ }
}
