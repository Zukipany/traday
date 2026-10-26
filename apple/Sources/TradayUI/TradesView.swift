// Source code is private. This file shows only its types and signatures.

import SwiftUI
import TradayKit

/// Every buy and sell of the last days, paired into trades, with the profit per trade, per day and in total.
@MainActor
struct TradesCard: View {
    @ObservedObject var store: DashboardStore

    var body: some View { /* private */ }

    private func totals(_ h: TradeHistory) -> some View { /* private */ }

    private func dayHeader(_ day: String, _ summary: TradeHistory.Day?) -> some View { /* private */ }
}

@MainActor
struct HistoryRow: View {
    let trade: TradeHistory.Trade

    var body: some View { /* private */ }
}

/// The running profit after each sell.
@MainActor
struct EquityLine: View {
    let values: [Double]

    var body: some View { /* private */ }
}
