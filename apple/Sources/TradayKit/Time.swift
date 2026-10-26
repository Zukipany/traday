// Source code is private. This file shows only its types and signatures.

import Foundation

/// Times from the server, and showing them in New York time (the market's) or your own.
public enum TradayTime {
    public static let newYork

    /// Parses "2026-10-22T10:05:00-04:00", with or without fractions of a second, "Z" or no offset
    /// (no offset means New York time). Also accepts a bare date ("2026-10-22", noon New York).
    public static func parse(_ text: String?) -> Date? { /* private */ }

    private static func formatter(_ format: String, zone: TimeZone?) -> DateFormatter { /* private */ }

    private static let nyTime
    private static let nyDay
    private static let localTimeF
    private static let localDayTimeF
    private static let lock

    private static func format(_ f: DateFormatter, _ d: Date) -> String { /* private */ }

    /// "10:05" in New York.
    public static func timeNY(_ date: Date) -> String { /* private */ }

    /// "10:05" in New York, from a server time; "–" if missing.
    public static func timeNY(_ iso: String?) -> String { /* private */ }

    /// "Thu, 22 Oct" for a New York date or time.
    public static func dayNY(_ iso: String?) -> String { /* private */ }

    /// "16:30" on this device's clock.
    public static func timeLocal(_ date: Date) -> String { /* private */ }

    /// "Mon 16:30" on this device's clock.
    public static func dayTimeLocal(_ date: Date) -> String { /* private */ }
}
