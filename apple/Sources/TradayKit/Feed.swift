// Source code is private. This file shows only its types and signatures.

import Foundation

/// One line of the Activity feed, built from one journal row (the same words as the web page).
public struct FeedItem: Sendable, Identifiable, Equatable {
    public let id: String
    /// "10:05" New York.
    public let time: String
    /// A short symbol for the icon: "B", "S", "⚡", "!", ...
    public let icon: String
    public let tone: Tone
    /// The bold start of the line ("Bought NVDA").
    public let headline: String
    /// The rest of the first line (" 13 @ 182.97").
    public let text: String
    /// A profit or loss to show coloured at the end of the first line.
    public let pnl: Double?
    /// The smaller second line.
    public let detail: String
}

public enum Feed {
    /// Turns journal rows (newest first, as the server sends them) into feed lines. News rows are left out.
    public static func items(_ rows: [JSONValue], limit: Int = 120) -> [FeedItem] { /* private */ }

    public static func item(_ r: JSONValue, index: Int = 0) -> FeedItem { /* private */ }

    /// Journal rows that are worth a notification (Mac) and how to say them.
    public static func notification(_ r: JSONValue) -> (title: String, body: String)? { /* private */ }
}
