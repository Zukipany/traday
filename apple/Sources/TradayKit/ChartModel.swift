// Source code is private. This file shows only its types and signatures.

import Foundation

/// The candle chart, ready to draw: dates instead of strings, the price range to show,
/// and the zones and markers the web page draws (opening range, entry window, target and stop).
public struct ChartModel: Sendable {
    public struct Bar: Sendable, Identifiable, Equatable {
        public let id: Int
        public let time: Date
        /// The middle of the candle's 5 minutes (where it is drawn).
        public let mid: Date
        public let open: Double
        public let high: Double
        public let low: Double
        public let close: Double
        public let volume: Double
        public var up: Bool { /* private */ }
        public var bodyLow: Double { /* private */ }
        public var bodyHigh: Double { /* private */ }
    }

    public struct Box: Sendable, Equatable {
        public let start: Date
        public let end: Date
        public let low: Double
        public let high: Double
    }

    public struct Trade: Sendable, Equatable {
        /// From the signal until the exit, now, or the close.
        public let start: Date
        public let end: Date
        public let entry: Double
        public let stop: Double
        public let target: Double
    }

    public struct Marker: Sendable, Identifiable, Equatable {
        public let id: String
        public let time: Date
        public let price: Double
        public let label: String
        public let tone: Tone
    }

    public let symbol: String
    public let open: Date
    public let close: Date
    public let rangeEnd: Date
    public let cutoff: Date
    public let flatten: Date
    public let lo: Double
    public let hi: Double
    public let bars: [Bar]
    /// The opening range box (9:30 to its end).
    public let range: Box?
    public let rangeMid: Double?
    public let trade: Trade?
    public let buy: Marker?
    public let exit: Marker?
    /// The bot's own fills from the journal (small diamonds).
    public let fills: [Marker]
    /// The time line, while the session runs.
    public let now: Date?
    public let last: Double?
    public let timeTicks: [Date]
    public let priceTicks: [Double]

    /// nil when there is no session to show (a holiday or no data).
    public init?(_ c: ChartData, intervalMinutes: Int = 5) { /* private */ }

    /// 1, 2 or 5 times a power of ten: the grid step for a price span.
    public static func niceStep(_ raw: Double) -> Double { /* private */ }

    /// Fraction of a candle slot the body fills, for a chart this many points wide.
    public func bodyWidth(plotWidth: Double, intervalMinutes: Int = 5) -> Double { /* private */ }
}

/// The Time Machine histogram, ready to draw.
public struct ReplayChart: Sendable {
    public struct Bin: Sendable, Identifiable, Equatable {
        public let id: Int
        public let low: Double
        public let high: Double
        public let count: Double
        public let tone: Tone
    }

    public let bins: [Bin]
    public let minX: Double
    public let maxX: Double
    public let maxCount: Double

    public init(_ r: ReplayResult) { /* private */ }
}
