// Source code is private. This file shows only its types and signatures.

import Combine
import Foundation
import TradayKit
import UserNotifications

/// What the menu bar shows: polls the dashboard every 5 seconds and turns new journal
/// events (buys, sells, errors, day summary) into Mac notifications.
@MainActor
final class StatusModel: ObservableObject {
    static let shared

    @Published private(set) var reachable
    @Published private(set) var mode
    @Published private(set) var market
    @Published private(set) var kill
    @Published private(set) var botRunning
    @Published private(set) var botLive
    @Published private(set) var botStatus
    @Published private(set) var pnl
    @Published private(set) var trades

    private var timer: Timer?
    private var seen
    private var primed
    private lazy var client

    var menuIcon: String { /* private */ }

    var summary: String { /* private */ }

    func start() { /* private */ }

    func poll() async { /* private */ }

    private func checkJournal() async { /* private */ }

    /// POST to the dashboard as the page would. Returns an error message, or nil when it worked.
    func post(_ path: String, body: [String: String]? = nil) async -> String? { /* private */ }
}

enum Notify {
    /// Notifications need a real app bundle (not `swift run`).
    static var available: Bool { /* private */ }

    static func requestPermission() { /* private */ }

    static func post(title: String, body: String) { /* private */ }
}
