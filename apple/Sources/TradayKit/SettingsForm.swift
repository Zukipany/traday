// Source code is private. This file shows only its types and signatures.

import Foundation

/// One field of the Settings panel (the same fields, labels and hints as the web page).
public struct SettingField: Sendable, Identifiable, Hashable {
    public enum Kind: Sendable, Hashable {
        case number, integer, time, text, list, bool
        case choice([Choice])
    }

    public struct Choice: Sendable, Hashable {
        public let value: String
        public let label: String
    }

    public let section: String
    public let key: String
    public let label: String
    public let kind: Kind
    public let help: String
    public var id: String { /* private */ }

    init(_ section: String, _ key: String, _ label: String, _ kind: Kind, _ help: String = "") { /* private */ }
}

public enum SettingsSpec {
    public static let risk: [SettingField]

    public static let paper: [SettingField]

    public static let strategy: [SettingField]

    public static let degiro: [SettingField]

    public static let alerts: [SettingField]

    public static var all: [SettingField] { /* private */ }
}

public struct SettingsError: Error, LocalizedError, Equatable {
    public let message: String
    public var errorDescription: String? { /* private */ }
}

/// The Settings panel's state: what traday.toml says, plus your edits, until you save.
public struct SettingsForm: Sendable, Equatable {
    /// The settings as loaded, by section.
    public private(set) var sections: [String: [String: JSONValue]]
    /// Text being edited, by field id.
    public var texts: [String: String]
    public var flags: [String: Bool]
    public var watchlist: [String]
    /// DEGIRO product ids pinned per ticker.
    public var pins: [String: String]

    public init(_ settings: JSONValue) { /* private */ }

    public func text(_ f: SettingField) -> String { /* private */ }
    public func flag(_ f: SettingField) -> Bool { /* private */ }

    /// Adds a ticker to the watchlist (upper case, no duplicates). Returns false if it is not a ticker.
    @discardableResult
    public mutating func add(symbol: String) -> Bool { /* private */ }

    public mutating func remove(symbol: String) { /* private */ }

    public mutating func pin(symbol: String, productId: String) { /* private */ }
    public mutating func unpin(symbol: String) { /* private */ }

    private func value(_ f: SettingField) throws -> JSONValue { /* private */ }

    /// What Save sends, exactly like the web page: whole sections, with `general` limited to the
    /// poll interval (the mode has its own switch).
    public func payload() throws -> JSONValue { /* private */ }
}
