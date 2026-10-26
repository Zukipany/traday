// Source code is private. This file shows only its types and signatures.

import Combine
import Foundation
import TradayKit

/// A question before anything consequential (stop the bot, real money, close a trade...).
/// With `typeWord`, the button only works after typing that word (LIVE).
public struct ConfirmRequest: Identifiable {
    public let id
    public let title: String
    public let message: String
    public var rows: [(String, String)]
    public var footer
    public let ok: String
    public var danger
    public var typeWord: String?
    public let action: @MainActor (String?) async -> Void
}

/// A short message at the bottom of the window.
public struct Toast: Identifiable, Equatable {
    public let id
    public let text: String
    public let error: Bool

    public init(_ text: String, error: Bool = false) { /* private */ }
}

/// The Time Machine's fields.
public struct TimeMachineInput: Equatable {
    public var entry
    public var stop
    public var target
    public var at
    public var sims
    /// Typed by you: the next refresh keeps it.
    public var edited
    public var forSymbol: String?
}

public enum SettingsTab: String, CaseIterable, Identifiable {
    case trading , strategy , degiro , alerts , phone
    public var id: String { /* private */ }
}

public enum PhoneTab: Hashable { case trade, chart, activity, agents, settings }

/// Everything the native dashboard shows and does, through the same API as the web page.
/// Both can be open at once: they control the same traday.
@MainActor
public final class DashboardStore: ObservableObject {
    public let client: TradayClient

    @Published public private(set) var world
    @Published public private(set) var status: Status?
    @Published public private(set) var scan: ScanResult?
    @Published public private(set) var chart: ChartData?
    @Published public private(set) var chartError: String?
    @Published public private(set) var feed: [FeedItem]
    @Published public private(set) var news: NewsResult?
    @Published public private(set) var connectionError: String?
    @Published public private(set) var needsPairing
    @Published public private(set) var symbol: String?

    @Published public var confirm: ConfirmRequest?
    @Published public var toast: Toast?
    @Published public var showSettings
    @Published public var settingsTab: SettingsTab
    @Published public var phoneTab: PhoneTab

    @Published public var tm
    @Published public private(set) var replay: ReplayResult?
    @Published public private(set) var replayError: String?
    @Published public private(set) var replaying

    @Published public private(set) var history: TradeHistory?
    @Published public private(set) var historyDays
    @Published public private(set) var agents: AgentsPayload?
    @Published public private(set) var story: Story?
    @Published public private(set) var agentsError: String?
    @Published public var showAgents
    @Published public private(set) var storyStep
    @Published public private(set) var storyPlaying
    private var storyTask: Task<Void, Never>?

    @Published public var form: SettingsForm?
    @Published public private(set) var settingsInfo: SettingsResponse?
    @Published public private(set) var settingsError: String?
    @Published public private(set) var remote: RemoteStatus?
    @Published public private(set) var remoteBusy
    @Published public private(set) var degiroResults: [DegiroProduct]
    @Published public private(set) var degiroBusy
    @Published public private(set) var lastTest: TestResult.Snapshot?

    /// Set by the Mac app: opens its own Settings window (where the Keychain login lives).
    public var openAppSettings: (() -> Void)?
    /// Set by the iPhone app: forget this computer and show the Connect screen again.
    public var disconnect: (() -> Void)?

    private var busy
    private var newsAt
    private var toastTask: Task<Void, Never>?

    public init(client: TradayClient) { /* private */ }

    public var isRemote: Bool { /* private */ }
    public var realMoney: Bool { /* private */ }

    static func message(_ error: Error) -> String { /* private */ }

    // MARK: - Refreshing

    /// Refreshes until the task is cancelled (the view went away): fast in the demo, every 5 s live.
    public func run() async { /* private */ }

    public func refresh() async { /* private */ }

    private func pickSymbol(_ scan: ScanResult) { /* private */ }

    public func setWorld(_ w: String) { /* private */ }

    public func select(_ s: String) { /* private */ }

    // MARK: - Messages

    public func show(_ text: String, error: Bool = false) { /* private */ }

    /// Runs an action, shows how it went, refreshes.
    public func perform(_ ok: String?, _ op: @escaping () async throws -> Void) async { /* private */ }

    // MARK: - The bot, the kill switch, closing trades

    public func botButton() { /* private */ }

    public func killButton() { /* private */ }

    /// Sell one open trade (or all with nil) at market now.
    public func close(_ sym: String?) { /* private */ }

    /// Paper / Real money. Real money needs a tested DEGIRO login and typing LIVE.
    public func switchMode(to mode: String) { /* private */ }

    public func setSpeed(_ x: Double) { /* private */ }

    public func restartDay() { /* private */ }

    // MARK: - Time Machine

    private func fillTimeMachine(_ c: ChartData) { /* private */ }

    public func runReplay() { /* private */ }

    // MARK: - Settings

    public func openSettings(_ tab: SettingsTab = .trading) { /* private */ }

    public func loadSettings() async { /* private */ }

    /// Returns true when saved.
    @discardableResult
    public func saveSettings() async -> Bool { /* private */ }

    public func resetPaper() { /* private */ }

    public func alertTest() { /* private */ }

    public func testDegiro() { /* private */ }

    public func saveLogin(username: String, password: String, totpSecret: String, intAccount: String) async -> Bool { /* private */ }

    public func forgetLogin() { /* private */ }

    public func searchDegiro(_ text: String) { /* private */ }

    // MARK: - Phone access (only on the computer itself)

    public func loadRemote() async { /* private */ }

    public func remoteSwitch(on: Bool) { /* private */ }

    public func newPairingCode() { /* private */ }

    // MARK: - Trades & profit

    public func setHistoryDays(_ days: Int) { /* private */ }

    // MARK: - The 11 agents

    /// Refreshes the agents while their screen is open.
    public func runAgents() async { /* private */ }

    public func refreshAgents() async { /* private */ }

    /// The story step whose agent is talking while the story plays.
    public var playingStep: Story.Step? { /* private */ }

    public func storyGo(_ i: Int) { /* private */ }

    public func storyPlay(_ on: Bool) { /* private */ }

    /// Settings from the agents' quick setup: on the Mac the agents sheet closes first.
    public func openSettingsFromAgents(_ tab: SettingsTab) { /* private */ }
}
