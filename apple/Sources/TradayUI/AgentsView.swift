// Source code is private. This file shows only its types and signatures.

import SwiftUI
import TradayKit

/// The 11 agents, like the web page's /agents: the team on its shelves, a card per agent with what it
/// is doing now, the reel's TSLA trade told step by step, and the quick setup for DEGIRO and the phone.
@MainActor
public struct AgentsView: View {
    @ObservedObject public var store: DashboardStore
    @State private var selected: AgentInfo?

    public init(store: DashboardStore) { /* private */ }

    public var body: some View { /* private */ }
}

/// The reel's black caption chips.
@MainActor
struct Chip: View {
    let text: String

    init(_ text: String) { /* private */ }

    var body: some View { /* private */ }
}

extension Palette {
    /// "#d0614b" from the server's palette.
    static func color(_ hex: String) -> Color { /* private */ }

    static func agentState(_ state: String) -> Color { /* private */ }
}

// MARK: - Painting a critter

enum AgentPainter {
    /// A different rhythm per agent, so they don't all blink at once.
    static func phase(_ id: String) -> Double { /* private */ }

    static func paint(_ gc: inout GraphicsContext, agent: AgentInfo, art: AgentsPayload, state: String, time: Double,
                      reduceMotion: Bool, origin: CGPoint, k: CGFloat) { /* private */ }
}

/// One agent, animated: hops when working, shakes on alert, sleeps when off, blinks now and then.
@MainActor
struct AgentSprite: View {
    let agent: AgentInfo
    let art: AgentsPayload
    let state: String
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View { /* private */ }

    private func draw(_ gc: inout GraphicsContext, size: CGSize, date: Date) { /* private */ }
}

/// All 11 on two shelves, like the reel's "ALL 11 SKILLS" scene. Tap one to read about it.
@MainActor
struct AgentRoom: View {
    let art: AgentsPayload
    let story: Story.Step?
    let pick: (AgentInfo) -> Void
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    static let size

    static func spot(_ i: Int) -> CGPoint { /* private */ }

    var body: some View { /* private */ }

    private func draw(_ gc: inout GraphicsContext, size: CGSize, date: Date) { /* private */ }
}

@MainActor
struct StateDot: View {
    let state: String

    var body: some View { /* private */ }
}

@MainActor
struct AgentCard: View {
    let number: Int
    let agent: AgentInfo
    let art: AgentsPayload
    let live: AgentLive

    var body: some View { /* private */ }
}

// MARK: - One agent, in full

@MainActor
struct AgentDetail: View {
    let agent: AgentInfo
    let art: AgentsPayload
    let story: Story?
    let close: () -> Void

    var body: some View { /* private */ }

    private func section<Content: View>(_ title: String, @ViewBuilder _ content: () -> Content) -> some View { /* private */ }
}

// MARK: - The trade from the reel, told by the agents

@MainActor
struct StoryPlayer: View {
    let story: Story
    let art: AgentsPayload
    @ObservedObject var store: DashboardStore

    var body: some View { /* private */ }
}

/// TSLA's 5-minute candles from 9:30 to 11:00, filled in up to the step's time, with the range,
/// the plan and the buy and sell as the story reaches them.
@MainActor
struct StoryChart: View {
    let story: Story
    let step: Story.Step

    static func minutes(_ ts: String) -> Int { /* private */ }

    var body: some View { /* private */ }
}

// MARK: - Quick setup: connect the trading platform

@MainActor
struct QuickSetup: View {
    @ObservedObject var store: DashboardStore
    let art: AgentsPayload

    var body: some View { /* private */ }

    private func step<Content: View>(_ n: Int, _ title: String, badge: String, ok: Bool, _ blurb: String,
                                     @ViewBuilder content: () -> Content) -> some View { /* private */ }

    private func check(_ ok: Bool, _ title: String, _ hint: String, bad: Bool = false) -> some View { /* private */ }
}
