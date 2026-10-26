// Source code is private. This file shows only its types and signatures.

import SwiftUI
import TradayKit

/// Live/Demo, Paper/Real money, the clocks, the bot and the kill switch.
@MainActor
struct TopBar: View {
    @ObservedObject var store: DashboardStore
    var compact

    var body: some View { /* private */ }

    private var badge: some View { /* private */ }

    private var worldPicker: some View { /* private */ }

    private var modePicker: some View { /* private */ }

    private var clocks: some View { /* private */ }

    private var marketPill: some View { /* private */ }

    private var demoControls: some View { /* private */ }

    private var botStatus: some View { /* private */ }

    @ViewBuilder
    private var botButton: some View { /* private */ }

    private var killButton: some View { /* private */ }
}

@MainActor
struct Brand: View {
    var body: some View { /* private */ }
}

@MainActor
struct ClockView: View {
    let time: String
    let caption: String

    var body: some View { /* private */ }
}

/// The line under the top bar: LIVE, demo, or when the market opens next.
@MainActor
struct BannerView: View {
    let kind: Labels.BannerKind
    let text: String

    var body: some View { /* private */ }
}

/// Asks before anything consequential; real money needs the typed word.
@MainActor
struct ConfirmSheet: View {
    let request: ConfirmRequest
    let done: () -> Void
    @State private var typed

    private var ready: Bool { /* private */ }

    var body: some View { /* private */ }

    private func finish() { /* private */ }
}

/// A short message at the bottom.
@MainActor
struct ToastView: View {
    let toast: Toast

    var body: some View { /* private */ }
}
