// Source code is private. This file shows only its types and signatures.

import Foundation

public struct Status: Decodable, Sendable {
    public let world: String
    public let demo: Bool
    public let speed: Double
    public let mode: String
    public let now: String
    public let market: String
    public let nextOpen: String
    public let nextClose: String
    public let showingDay: String
    public let liveSession: Bool
    public let kill: Bool
    public let bot: BotInfo
    public let account: Account
    public let today: Today
    public let watchlist: [String]
    public let strategy: StrategyInfo
    public let risk: RiskInfo
    public let degiro: DegiroInfo?
    /// "local" (on the computer itself) or "remote" (a paired phone). Missing on older servers.
    public let client: String?

    enum CodingKeys: String, CodingKey {
        case world, demo, speed, mode, now, market, kill, bot, account, today, watchlist, strategy, risk, degiro, client
        case nextOpen , nextClose , showingDay , liveSession
    }

    /// Real money: the live view in DEGIRO mode.
    public var realMoney: Bool { /* private */ }
    public var isRemote: Bool { /* private */ }
}

public struct BotInfo: Decodable, Sendable {
    public let running: Bool
    public let status: String
    public let canStart: Bool
    public let note: String
    public let error: String
    public let live: Bool
    public let needsConfirm: Bool

    enum CodingKeys: String, CodingKey {
        case running, status, note, error, live
        case canStart , needsConfirm
    }

    public init(from decoder: Decoder) throws { /* private */ }
}

public struct Account: Decodable, Sendable {
    /// "paper" or "degiro".
    public let kind: String
    public let cash: Double?
    /// Paper: the starting cash.
    public let start: Double?
    public let positions: [Position]
    /// DEGIRO: logged in and read the account?
    public let connected: Bool?
    public let error: String?
    public let orders: Int?
    public let intAccount: LooseString?

    enum CodingKeys: String, CodingKey {
        case kind, cash, start, positions, connected, error, orders
        case intAccount
    }

    public init(from decoder: Decoder) throws { /* private */ }
}

public struct Position: Decodable, Sendable, Identifiable {
    public let symbol: String
    public let qty: Double
    public let avgPrice: Double
    public var id: String { /* private */ }

    enum CodingKeys: String, CodingKey {
        case symbol, qty
        case avgPrice
    }
}

public struct Today: Decodable, Sendable {
    public let day: String
    public let trades: Int
    public let pnl: Double
    public let openTrades: [OpenTrade]

    enum CodingKeys: String, CodingKey {
        case day, trades, pnl
        case openTrades
    }
}

/// A trade the bot holds right now.
public struct OpenTrade: Decodable, Sendable, Identifiable, Equatable {
    public let symbol: String
    public let qty: Double
    public let entry: Double
    public let stop: Double
    public let target: Double
    public let signalTime: String
    public let carriedFrom: String?
    public var id: String { /* private */ }

    enum CodingKeys: String, CodingKey {
        case symbol, qty, entry, stop, target
        case signalTime , carriedFrom
    }

    public init(symbol: String, qty: Double, entry: Double, stop: Double, target: Double, signalTime: String,
                carriedFrom: String? = nil) { /* private */ }
}

public struct StrategyInfo: Decodable, Sendable {
    public let rangeMinutes: Int
    public let intervalMinutes: Int
    public let entryCutoff: String
    public let flattenAt: String

    enum CodingKeys: String, CodingKey {
        case rangeMinutes , intervalMinutes
        case entryCutoff , flattenAt
    }

    public init(rangeMinutes: Int = 15, intervalMinutes: Int = 5, entryCutoff: String = "11:30", flattenAt: String = "15:50") { /* private */ }
}

public struct RiskInfo: Decodable, Sendable {
    public let maxRiskPerTrade: Double
    public let maxPositionValue: Double
    public let maxTradesPerDay: Int
    public let maxDailyLoss: Double

    enum CodingKeys: String, CodingKey {
        case maxRiskPerTrade , maxPositionValue
        case maxTradesPerDay , maxDailyLoss
    }
}

public struct DegiroInfo: Decodable, Sendable {
    public let configured: Bool
    /// "keychain" (the Mac app) or ".env".
    public let source: String
    public let userHint: String
    public let hasTotp: Bool
    public let intAccount: String
    /// Logged in successfully in this session.
    public let ok: Bool
    public let checkedAt: String?
    public let error: String
    /// The degiro-connector library is installed.
    public let installed: Bool

    enum CodingKeys: String, CodingKey {
        case configured, source, ok, error, installed
        case userHint , hasTotp , intAccount , checkedAt
    }

    public init(from decoder: Decoder) throws { /* private */ }
}

// MARK: - Scanner and chart

public struct ScanResult: Decodable, Sendable {
    public let day: String
    public let liveSession: Bool
    public let rows: [ScanRow]

    enum CodingKeys: String, CodingKey {
        case day, rows
        case liveSession
    }
}

public struct ScanRow: Decodable, Sendable, Identifiable {
    public let symbol: String
    public let trade: OpenTrade?
    public let done: Bool
    public let status: String
    public let error: String?
    public let last: Double?
    public let range: RangeInfo?
    public let plan: PlanInfo?
    public let spark: [Double]
    public var id: String { /* private */ }

    enum CodingKeys: String, CodingKey {
        case symbol, trade, done, status, error, last, range, plan, spark
    }

    public init(from decoder: Decoder) throws { /* private */ }
}

public struct RangeInfo: Decodable, Sendable, Equatable {
    public let high: Double
    public let low: Double
    public let mid: Double
    public let widthPct: Double
    public let end: String

    enum CodingKeys: String, CodingKey {
        case high, low, mid, end
        case widthPct
    }
}

/// Entry, stop and target, from the rules (a plan) or from the bot's real trade.
public protocol Levels {
    var entry: Double { get }
    var stop: Double { get }
    var target: Double { get }
    var signalTime: String { get }
}

public struct PlanInfo: Decodable, Sendable, Equatable, Levels {
    public let entry: Double
    public let stop: Double
    public let target: Double
    public let signalTime: String
    public let riskPerShare: Double
    public let rewardPerShare: Double

    enum CodingKeys: String, CodingKey {
        case entry, stop, target
        case signalTime , riskPerShare , rewardPerShare
    }
}

extension OpenTrade: Levels {}

public struct ExitInfo: Decodable, Sendable, Equatable {
    public let time: String
    public let price: Double
    /// "target", "stop", "close", "manual", ...
    public let reason: String
}

public struct SessionInfo: Decodable, Sendable, Equatable {
    public let open: String
    public let close: String
    public let rangeEnd: String
    public let cutoff: String
    public let flatten: String

    enum CodingKeys: String, CodingKey {
        case open, close, cutoff, flatten
        case rangeEnd
    }
}

/// One 5-minute candle: sent as [time, open, high, low, close, volume].
public struct Candle: Decodable, Sendable, Equatable {
    public let ts: String
    public let open: Double
    public let high: Double
    public let low: Double
    public let close: Double
    public let volume: Double

    public init(ts: String, open: Double, high: Double, low: Double, close: Double, volume: Double = 0) { /* private */ }

    public init(from decoder: Decoder) throws { /* private */ }
}

public struct ChartData: Decodable, Sendable {
    public let symbol: String
    public let day: String
    public let liveSession: Bool
    public let now: String
    public let status: String
    public let last: Double?
    public let candles: [Candle]
    public let range: RangeInfo?
    public let plan: PlanInfo?
    public let exit: ExitInfo?
    public let trade: OpenTrade?
    public let events: [JSONValue]
    public let session: SessionInfo?

    enum CodingKeys: String, CodingKey {
        case symbol, day, now, status, last, candles, range, plan, exit, trade, events, session
        case liveSession
    }

    public init(from decoder: Decoder) throws { /* private */ }

    /// The bot's real trade beats the textbook plan.
    public var levels: (any Levels)? { /* private */ }
}

// MARK: - Time Machine

public struct ReplayResult: Decodable, Sendable {
    public let symbol: String
    public let day: String
    public let entry: Double
    public let stop: Double
    public let target: Double
    /// Entry time, "HH:MM" New York.
    public let start: String
    public let sims: Int
    public let sessions: Int
    public let targetFirst: Double
    public let stopFirst: Double
    public let neither: Double
    public let green: Double
    public let p5: Double
    public let p50: Double
    public let p95: Double
    /// [low, high, count] per bin.
    public let hist: [[Double]]
    public let backtest: Backtest

    enum CodingKeys: String, CodingKey {
        case symbol, day, entry, stop, target, start, sims, sessions, neither, green, p5, p50, p95, hist, backtest
        case targetFirst , stopFirst
    }
}

public struct Backtest: Decodable, Sendable {
    public let sessions: Int
    public let triggers: Int
    public let target: Int
    public let stop: Int
    public let close: Int
    public let winRate: Double
    public let avgR: Double
    public let totalR: Double

    enum CodingKeys: String, CodingKey {
        case sessions, triggers, target, stop, close
        case winRate , avgR , totalR
    }
}

// MARK: - News, settings, DEGIRO search, phone access

public struct NewsResult: Decodable, Sendable {
    public let note: String
    public let items: [NewsItem]
}

public struct NewsItem: Decodable, Sendable, Identifiable {
    public let symbol: String
    public let title: String
    public let link: String
    public let hot: Bool
    public let published: String?
    public var id: String { /* private */ }
}

public struct SettingsResponse: Decodable, Sendable {
    /// traday.toml as an object of sections: {"risk": {...}, "strategy": {...}, ...}.
    public let settings: JSONValue
    public let path: String
    public let degiro: DegiroInfo
    public let botRunning: Bool

    enum CodingKeys: String, CodingKey {
        case settings, path, degiro
        case botRunning
    }
}

public struct DegiroProduct: Decodable, Sendable, Identifiable {
    public let id: LooseString
    public let symbol: String?
    public let name: String?
    public let isin: String?
    public let exchangeId: LooseString?
    public let currency: String?
}

public struct TestResult: Decodable, Sendable {
    public struct Snapshot: Decodable, Sendable {
        public let intAccount: LooseString?
        public let cash: Double?
        public let orders: Int?
        public let positions: [Position]?

        enum CodingKeys: String, CodingKey {
            case cash, orders, positions
            case intAccount
        }
    }

    public let degiro: DegiroInfo
    public let account: Snapshot?
}

public struct RemoteStatus: Decodable, Sendable {
    public struct Tailscale: Decodable, Sendable {
        public let installed: Bool
        public let running: Bool
        public let dnsName: String
        public let login: String
        public let error: String

        enum CodingKeys: String, CodingKey {
            case installed, running, login, error
            case dnsName
        }

        public init(from decoder: Decoder) throws { /* private */ }
    }

    public let tailscale: Tailscale
    public let on: Bool
    public let url: String
    public let pairURL: String

    enum CodingKeys: String, CodingKey {
        case tailscale, on, url
        case pairURL
    }
}

/// GET /api/<world>/trades?days=N: every buy and sell, paired into trades with their profit.
public struct TradeHistory: Decodable, Sendable {
    public struct Trade: Decodable, Sendable, Identifiable, Equatable {
        public let symbol: String
        public let qty: Double
        public let entry: Double?
        public let exit: Double?
        public let stop: Double?
        public let target: Double?
        public let boughtAt: String?
        public let soldAt: String?
        /// "target", "stop", "close", "manual", "kill switch", ...
        public let reason: String
        public let fees: Double
        public let pnl: Double?
        public let pnlPct: Double?
        public let r: Double?
        public let open: Bool
        /// The day it counts on: the sell day (or the buy day while open).
        public let day: String

        enum CodingKeys: String, CodingKey {
            case symbol, qty, entry, exit, stop, target, reason, fees, pnl, r, open, day
            case boughtAt , soldAt , pnlPct
        }

        public var id: String { /* private */ }

        public init(from decoder: Decoder) throws { /* private */ }
    }

    public struct Day: Decodable, Sendable, Identifiable, Equatable {
        public let day: String
        public let trades: Int
        public let wins: Int
        public let losses: Int
        public let pnl: Double
        public let fees: Double
        public var id: String { /* private */ }
    }

    public struct Total: Decodable, Sendable, Equatable {
        public let trades: Int
        public let open: Int
        public let wins: Int
        public let losses: Int
        public let winRate: Double
        public let pnl: Double
        public let fees: Double
        public let best: Double
        public let worst: Double
        public let avg: Double

        enum CodingKeys: String, CodingKey {
            case trades, open, wins, losses, pnl, fees, best, worst, avg
            case winRate
        }
    }

    /// Newest first.
    public let trades: [Trade]
    /// Newest first.
    public let days: [Day]
    public let total: Total
    /// [time, running P&L] after each sell, oldest first.
    public let curve: [[JSONValue]]

    /// The trades grouped by the day they count on, newest day first.
    public var byDay: [(day: String, trades: [Trade], summary: Day?)] { /* private */ }

    /// Running P&L after each sell, starting at 0.
    public var equity: [Double] { /* private */ }
}

extension TradayClient {
    public func trades(_ world: String, days: Int = 30) async throws -> TradeHistory { /* private */ }
}
