// Source code is private. This file shows only its types and signatures.

import Foundation

/// The pairing link from Settings → Phone: https://<mac>.<tailnet>.ts.net/pair?code=<code>.
public struct Pairing: Equatable, Sendable {
    /// The dashboard's address, without a path: https://my-mac.tail1234.ts.net
    public let baseURL: URL
    public let code: String

    public init(baseURL: URL, code: String) { /* private */ }

    /// Reads a pasted pairing link. Spaces and line breaks around it are ignored.
    public static func parse(_ text: String) -> Pairing? { /* private */ }
}
