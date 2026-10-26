// Source code is private. This file shows only its types and signatures.

import SwiftUI
import TradayKit

/// The whole native dashboard. Wide (the Mac): the web page's three columns.
/// Narrow (the iPhone): tabs for trading, the chart, the activity and the settings.
@MainActor
public struct DashboardView: View {
    @ObservedObject public var store: DashboardStore

    public init(store: DashboardStore) { /* private */ }

    public var body: some View { /* private */ }

    // MARK: - Wide

    private var wide: some View { /* private */ }

    private func column<Content: View>(@ViewBuilder _ content: () -> Content) -> some View { /* private */ }

    @ViewBuilder
    private var banners: some View { /* private */ }

    // MARK: - Compact (iPhone)

    private var compact: some View { /* private */ }
}
