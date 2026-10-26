// Source code is private. This file shows only its types and signatures.

import Foundation

/// Any JSON value. Used where the server sends free-form objects (settings, journal rows)
/// and for request bodies. Keys are kept exactly as the server spells them.
public enum JSONValue: Codable, Equatable, Sendable {
    case null
    case bool(Bool)
    case number(Double)
    case string(String)
    case array([JSONValue])
    case object([String: JSONValue])

    public init(from decoder: Decoder) throws { /* private */ }

    public func encode(to encoder: Encoder) throws { /* private */ }

    public subscript(key: String) -> JSONValue? { /* private */ }

    public var string: String? { /* private */ }

    public var double: Double? { /* private */ }

    public var int: Int? { /* private */ }

    public var bool: Bool? { /* private */ }

    public var array: [JSONValue]? { /* private */ }

    public var object: [String: JSONValue]? { /* private */ }

    public var isNull: Bool { /* private */ }

    /// A list of strings (e.g. a watchlist), or [] if this is not one.
    public var strings: [String] { /* private */ }
}

extension JSONValue: ExpressibleByStringLiteral, ExpressibleByFloatLiteral, ExpressibleByIntegerLiteral,
    ExpressibleByBooleanLiteral, ExpressibleByArrayLiteral, ExpressibleByDictionaryLiteral, ExpressibleByNilLiteral {
    public init(stringLiteral value: String) { /* private */ }
    public init(floatLiteral value: Double) { /* private */ }
    public init(integerLiteral value: Int) { /* private */ }
    public init(booleanLiteral value: Bool) { /* private */ }
    public init(arrayLiteral elements: JSONValue...) { /* private */ }
    public init(dictionaryLiteral elements: (String, JSONValue)...) { /* private */ }
    public init(nilLiteral: ()) { /* private */ }
}

/// A value the server sends sometimes as a number and sometimes as text (account numbers, ids).
public struct LooseString: Decodable, Hashable, Sendable, CustomStringConvertible {
    public let value: String

    public init(_ value: String) { /* private */ }

    public init(from decoder: Decoder) throws { /* private */ }

    public var description: String { /* private */ }
}
