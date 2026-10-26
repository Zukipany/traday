// Source code is private. This file shows only its types and signatures.

import Charts
import SwiftUI
import TradayKit

/// The selected stock: 5-minute candles with the opening range, the entry, stop and target,
/// and the plan in numbers underneath.
@MainActor
struct ChartCard: View {
    @ObservedObject var store: DashboardStore
    var height: CGFloat

    var body: some View { /* private */ }

    private var header: some View { /* private */ }

    private var legend: some View { /* private */ }

    private func planStrip(_ chart: ChartData) -> some View { /* private */ }
}

@MainActor
struct LegendItem: View {
    let color: Color
    let text: String
    let dashed: Bool

    var body: some View { /* private */ }
}

/// The candle chart itself (Swift Charts).
@MainActor
struct CandleChart: View {
    let model: ChartModel

    var body: some View { /* private */ }

    @ChartContentBuilder
    private var zones: some ChartContent { /* private */ }

    @ChartContentBuilder
    private var levels: some ChartContent { /* private */ }

    @ChartContentBuilder
    private var markers: some ChartContent { /* private */ }
}
