// Source code is private. This file shows only its types and signatures.

import Foundation

public struct AgentsPayload: Decodable, Sendable {
    public let cast: [AgentInfo]
    public let critter: Critter
    public let palette: [String: String]
    /// What each agent is doing now, by id. Empty in an offline copy.
    public let live: [String: AgentLive]
    public let autopilot: Autopilot?
    public let schedule: AgentSchedule
    public let now: String?
    public let setup: AgentSetup?
    /// "local" or "remote" (a paired phone).
    public let client: String?

    enum CodingKeys: String, CodingKey { case cast, critter, palette, live, autopilot, schedule, now, setup, client }

    public init(from decoder: Decoder) throws { /* private */ }

    public func agent(_ id: String) -> AgentInfo? { /* private */ }

    /// The agent's line right now, or when it works (an offline copy has no live lines).
    public func liveLine(_ id: String) -> AgentLive { /* private */ }
}

public struct AgentInfo: Decodable, Sendable, Identifiable, Equatable {
    public let id: String
    public let name: String
    public let tagline: String
    public let job: String
    public let when: String
    public let code: String
    /// The Claude skill that speaks for it ("" when none) and something to say to reach it.
    public let skill: String
    public let ask: String
    public let rules: [String]
    public let sprite: AgentSprite
}

public struct AgentSprite: Decodable, Sendable, Equatable {
    public let w: Int
    public let h: Int
    /// Where the critter's top-left corner goes.
    public let body: [Int]
    public let props: [AgentProp]
}

public struct AgentProp: Decodable, Sendable, Equatable {
    public let name: String
    public let x: Int
    public let y: Int
    public let rows: [String]
}

public struct Critter: Decodable, Sendable, Equatable {
    public let w: Int
    public let h: Int
    /// "stand", "blink" and "step".
    public let frames: [String: [String]]
}

public struct AgentLive: Decodable, Sendable, Equatable {
    /// idle, working, done, alert or off.
    public let state: String
    public let says: String

    public init(state: String, says: String) { /* private */ }
}

public struct Autopilot: Decodable, Sendable {
    public let running: Bool
    public let status: String
    public let line: String
    public let market: String
    public let time: String
    public let demo: Bool
}

public struct AgentSchedule: Decodable, Sendable {
    public let wake: String
    public let open: String
    public let rangeEnd: String
    public let cutoff: String
    public let flatten: String
    public let close: String
    public let pollSeconds: Int

    enum CodingKeys: String, CodingKey {
        case wake, open, cutoff, flatten, close
        case rangeEnd , pollSeconds
    }
}

/// The quick-setup checks: never a password, a token or a topic.
public struct AgentSetup: Decodable, Sendable {
    public struct Degiro: Decodable, Sendable {
        public let installed: Bool
        public let configured: Bool
        public let hasTotp: Bool
        public let ok: Bool
        public let error: String
        public let source: String
        public let pinned: [String]

        enum CodingKeys: String, CodingKey {
            case installed, configured, ok, error, source, pinned
            case hasTotp
        }

        public init(from decoder: Decoder) throws { /* private */ }
    }

    public let mode: String
    public let bot: BotInfo
    public let alerts: [String: Bool]
    public let paperCash: Double
    public let watchlist: [String]
    public let degiro: Degiro

    enum CodingKeys: String, CodingKey {
        case mode, bot, alerts, watchlist, degiro
        case paperCash
    }

    public var alertsOn: Bool { /* private */ }
}

// MARK: - The story of one trade

public struct Story: Decodable, Sendable {
    public struct Step: Decodable, Sendable, Identifiable, Equatable {
        public let t: String
        public let agent: String
        public let title: String
        public let text: String
        /// What the chart shows by now: range, entry, plan, buy, sell.
        public let show: [String]
        public var id: String { /* private */ }
    }

    public struct Range: Decodable, Sendable, Equatable {
        public let high: Double
        public let low: Double
        public let end: String
    }

    public struct Plan: Decodable, Sendable, Equatable {
        public let entry: Double
        public let stop: Double
        public let target: Double
        public let signalTime: String

        enum CodingKeys: String, CodingKey {
            case entry, stop, target
            case signalTime
        }
    }

    public struct Exit: Decodable, Sendable, Equatable {
        public let time: String
        public let price: Double
        public let reason: String
        public let pnl: Double
        public let qty: Double
    }

    public let symbol: String
    public let day: String
    public let steps: [Step]
    public let candles: [Candle]
    public let range: Range?
    public let plan: Plan?
    public let exit: Exit?
    public let note: String?
}

// MARK: - Pixel art

/// One horizontal run of same-coloured pixels, in sprite pixels.
public struct PixelRun: Equatable, Sendable {
    public let x: Int
    public let y: Int
    public let width: Int
    /// "#rrggbb"
    public let color: String
}

/// How a critter stands at a moment: the web page's `pose()`, so both move alike.
public struct AgentPose: Equatable, Sendable {
    public var dx
    public var dy
    public var frame
    /// Held props bob by this much.
    public var bob

    public init(state: String, time t: Double, reduceMotion: Bool = false) { /* private */ }
}

public enum PixelArt {
    public static let z
    public static let bang

    public static func runs(_ rows: [String], palette: [String: String], x0: Int = 0, y0: Int = 0) -> [PixelRun] { /* private */ }

    /// Everything to paint for one agent at a moment (shadow and "zz" aside), in sprite pixels.
    public static func agent(_ a: AgentInfo, critter: Critter, palette: [String: String], pose: AgentPose,
                             at origin: (x: Int, y: Int) = (0, 0)) -> [PixelRun] { /* private */ }

    /// "#d0614b" -> (0.82, 0.38, 0.29)
    public static func rgb(_ hex: String) -> (red: Double, green: Double, blue: Double)? { /* private */ }
}

extension TradayClient {
    public func agents(_ world: String) async throws -> AgentsPayload { /* private */ }
    public func story() async throws -> Story { /* private */ }
}
