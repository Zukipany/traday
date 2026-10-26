// Source code is private. This file shows only its types and signatures.

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

/// A message from the traday server (or the network), ready to show.
public struct TradayError: Error, LocalizedError, Equatable {
    public let message: String
    /// The HTTP status, or 0 for network problems.
    public let status: Int

    public init(_ message: String, status: Int = 0) { /* private */ }

    /// This phone is not (or no longer) paired.
    public var needsPairing: Bool { /* private */ }
    public var errorDescription: String? { /* private */ }
}

/// Talks to the traday dashboard server: the same JSON API the web page uses.
/// On the Mac it calls http://127.0.0.1:8765; a phone calls https://<mac>.<tailnet>.ts.net with its pairing code.
public final class TradayClient: @unchecked Sendable {
    public let baseURL: URL
    /// The pairing code, sent as a Bearer token (phones only).
    public let code: String?
    private let session: URLSession

    public init(baseURL: URL, code: String? = nil, session: URLSession? = nil) { /* private */ }

    // MARK: - Plumbing

    /// GET/POST /api/<world>/<what>?<query>
    public func request(_ what: String, world: String, query: [String: String] = [:], body: JSONValue? = nil,
                        post: Bool = false) -> URLRequest { /* private */ }

    private func data(_ req: URLRequest) async throws -> Data { /* private */ }

    public func get<T: Decodable>(_ type: T.Type, _ what: String, world: String = "live",
                                  query: [String: String] = [:]) async throws -> T { /* private */ }

    /// POST an action. Returns the server's answer ({"ok": true, ...}).
    @discardableResult
    public func post(_ what: String, world: String = "live", query: [String: String] = [:],
                     body: JSONValue? = nil) async throws -> JSONValue { /* private */ }

    private func post<T: Decodable>(_ type: T.Type, _ what: String, world: String = "live", body: JSONValue? = nil) async throws -> T { /* private */ }

    // MARK: - Reading

    public func status(_ world: String) async throws -> Status { /* private */ }
    public func scan(_ world: String) async throws -> ScanResult { /* private */ }
    public func chart(_ world: String, symbol: String) async throws -> ChartData { /* private */ }
    public func journal(_ world: String, days: Int = 1) async throws -> [JSONValue] { /* private */ }
    public func news(_ world: String) async throws -> NewsResult { /* private */ }

    /// The Time Machine. Without levels it replays today's breakout of `symbol`.
    public func replay(_ world: String, symbol: String, entry: String = "", stop: String = "", target: String = "",
                       at: String = "", sims: Int = 10_000) async throws -> ReplayResult { /* private */ }

    public func settings() async throws -> SettingsResponse { /* private */ }
    public func degiroSearch(_ text: String) async throws -> [DegiroProduct] { /* private */ }
    public func remoteStatus() async throws -> RemoteStatus { /* private */ }

    // MARK: - Doing

    public func kill(_ world: String, on: Bool) async throws { /* private */ }
    public func botStart(_ world: String, confirm: String? = nil) async throws { /* private */ }
    public func botStop(_ world: String) async throws { /* private */ }
    /// Sells one open trade (or all of them with nil) at market now.
    public func close(_ world: String, symbol: String?) async throws { /* private */ }
    public func demoRestart() async throws { /* private */ }
    public func demoSpeed(_ x: Double) async throws { /* private */ }
    public func setMode(_ mode: String, confirm: String? = nil) async throws { /* private */ }
    /// Returns whether the bot must be restarted to use them.
    public func saveSettings(_ payload: JSONValue) async throws -> Bool { /* private */ }
    public func saveCredentials(username: String, password: String, totpSecret: String, intAccount: String) async throws -> DegiroInfo { /* private */ }
    public func forgetCredentials() async throws { /* private */ }
    public func degiroTest() async throws -> TestResult { /* private */ }
    public func alertTest() async throws { /* private */ }
    public func paperReset() async throws { /* private */ }
    public func remote(on: Bool) async throws -> RemoteStatus { /* private */ }
    public func remoteNewCode() async throws -> RemoteStatus { /* private */ }
}
