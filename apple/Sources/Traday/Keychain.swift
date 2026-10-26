// Source code is private. This file shows only its types and signatures.

import Foundation
import Security

/// The DEGIRO login lives in the macOS Keychain, not in a file. The app hands it to traday
/// as environment variables when it starts the dashboard.
enum Keychain {
    static let service
    static let degiroKeys

    private static func query(_ account: String) -> [String: Any] { /* private */ }

    static func get(_ account: String) -> String? { /* private */ }

    /// Saves a value (an empty value removes it). Returns false if the Keychain refused.
    @discardableResult
    static func set(_ account: String, _ value: String) -> Bool { /* private */ }

    static func removeAll() { /* private */ }

    static var hasLogin: Bool { /* private */ }
}
