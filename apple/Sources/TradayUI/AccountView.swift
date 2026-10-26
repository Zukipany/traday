// Source code is private. This file shows only its types and signatures.

import SwiftUI
import TradayKit

/// The paper or DEGIRO account, today's result, and the open trades with their Close buttons.
@MainActor
struct AccountCard: View {
    @ObservedObject var store: DashboardStore

    var body: some View { /* private */ }

    @ViewBuilder
    private func content(_ st: Status) -> some View { /* private */ }
}

@MainActor
struct TradeRow: View {
    let trade: OpenTrade
    let close: () -> Void

    var body: some View { /* private */ }
}
