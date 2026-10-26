// Source code is private. This file shows only its types and signatures.

import SwiftUI
import TradayKit

/// What the bot did today: signals, skips, buys, sells, errors, your own actions.
@MainActor
struct ActivityCard: View {
    @ObservedObject var store: DashboardStore

    var body: some View { /* private */ }
}

@MainActor
struct FeedRow: View {
    let item: FeedItem

    var body: some View { /* private */ }

    private var line: Text { /* private */ }
}

/// Recent headlines for the watchlist; "!" marks the kind that usually moves a stock.
@MainActor
struct NewsCard: View {
    @ObservedObject var store: DashboardStore

    var body: some View { /* private */ }
}
