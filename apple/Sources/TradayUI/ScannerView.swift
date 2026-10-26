// Source code is private. This file shows only its types and signatures.

import SwiftUI
import TradayKit

/// The watchlist: each stock's opening range and whether it has broken out.
@MainActor
struct ScannerCard: View {
    @ObservedObject var store: DashboardStore

    var body: some View { /* private */ }

    private var dayNote: String { /* private */ }
}

@MainActor
struct ScanRowView: View {
    let row: ScanRow
    let selected: Bool

    var body: some View { /* private */ }
}

/// The day's closes as a small line, with the range high dashed.
@MainActor
struct Sparkline: View {
    let points: [Double]
    let rangeHigh: Double?
    let rangeLow: Double?
    /// A full session has 78 five-minute candles: a morning only fills part of the width.
    var slots

    var body: some View { /* private */ }
}
