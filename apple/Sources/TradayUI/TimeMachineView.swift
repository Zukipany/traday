// Source code is private. This file shows only its types and signatures.

import Charts
import SwiftUI
import TradayKit

/// Replays the rest of the day thousands of times from the stock's own past sessions.
@MainActor
struct TimeMachineCard: View {
    @ObservedObject var store: DashboardStore
    var compact

    var body: some View { /* private */ }

    private var note: String { /* private */ }

    private func field(_ title: String, _ value: Binding<String>, decimal: Bool = true) -> some View { /* private */ }

    private func binding(_ key: WritableKeyPath<TimeMachineInput, String>) -> Binding<String> { /* private */ }

    private var form: some View { /* private */ }

    @ViewBuilder
    private func results(_ r: ReplayResult) -> some View { /* private */ }
}

@MainActor
struct OutcomeBar: View {
    let name: String
    let value: Double
    let color: Color

    var body: some View { /* private */ }
}

@MainActor
struct ReplayHistogram: View {
    let result: ReplayResult

    var body: some View { /* private */ }

    private func color(_ t: Tone) -> Color { /* private */ }

    private func line(_ price: Double, _ name: String, _ color: Color) -> some ChartContent { /* private */ }
}
