// Source code is private. This file shows only its types and signatures.

import Foundation

/// Colours by meaning; each app maps them to its own palette.
public enum Tone: String, Sendable {
    case neutral, green, red, blue, amber, gray
}

/// Everything the dashboards say in words, kept in one place so the web page and the apps agree.
public enum Labels {
    /// Scanner status -> (label, tone).
    public static func scan(_ status: String) -> (String, Tone) { /* private */ }

    /// What the bot is doing, in words.
    public static func bot(_ status: String) -> String { /* private */ }

    /// The bot's headline: "watching for breakouts" or "bot off".
    public static func botHeadline(_ bot: BotInfo) -> String { /* private */ }

    /// The small line under it.
    public static func botSub(_ st: Status) -> String { /* private */ }

    /// The start/stop button's title.
    public static func botButton(_ st: Status) -> String { /* private */ }

    /// The badge next to the logo: DEMO, PAPER, REAL MONEY or LIVE · DEGIRO.
    public static func badge(_ st: Status) -> (String, Tone) { /* private */ }

    public enum BannerKind: Sendable { case live, demo, info }

    /// The line under the top bar, or nil when there is nothing to say.
    public static func banner(_ st: Status) -> (BannerKind, String)? { /* private */ }

    /// The market pill: "open", "pre-market", ... or "replay 60×" in the demo.
    public static func market(_ st: Status) -> (String, Tone) { /* private */ }

    /// The second line of a scanner row.
    public static func scanDetail(_ row: ScanRow) -> String { /* private */ }

    private static func fmtPct(_ x: Double) -> String { /* private */ }

    /// Under the chart: what the rules say about this stock now.
    public static func explain(_ status: String, range: RangeInfo?, strategy: StrategyInfo) -> String { /* private */ }

    /// One box of the plan strip under the chart.
    public struct PlanBox: Sendable, Identifiable {
        public let title: String
        public let value: String
        public let detail: String
        public let tone: Tone
        public var id: String { /* private */ }
    }

    /// Get in / Stop / Target / Out by (or the range levels before a breakout).
    public static func planStrip(_ chart: ChartData, strategy: StrategyInfo) -> [PlanBox] { /* private */ }

    /// The chart's status pill: "in trade" beats the scanner status.
    public static func chartStatus(_ chart: ChartData) -> (String, Tone) { /* private */ }

    /// The account panel's title.
    public static func accountTitle(_ st: Status) -> String { /* private */ }

    /// Paper: cash plus open trades at their entry price.
    public static func paperValue(_ st: Status) -> Double { /* private */ }
}
