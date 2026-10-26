// Source code is private. This file shows only its types and signatures.

import SwiftUI
import TradayKit
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif
#if canImport(CoreImage)
import CoreImage
import CoreImage.CIFilterBuiltins
#endif

/// The web page's Settings drawer, natively: Watchlist & risk, Strategy, DEGIRO, Alerts, Phone.
/// Saving writes traday.toml through the server, exactly like the page.
@MainActor
struct SettingsPanel: View {
    @ObservedObject var store: DashboardStore
    @State private var newSymbol
    @State private var search
    @State private var user
    @State private var password
    @State private var totp
    @State private var account

    private var tabs: [SettingsTab] { /* private */ }

    var body: some View { /* private */ }

    @ViewBuilder
    private var tabContent: some View { /* private */ }

    private var saveBar: some View { /* private */ }

    // MARK: - Fields

    private func text(_ f: SettingField) -> Binding<String> { /* private */ }

    private func flag(_ f: SettingField) -> Binding<Bool> { /* private */ }

    @ViewBuilder
    private func field(_ f: SettingField) -> some View { /* private */ }

    private func grid(_ fields: [SettingField]) -> some View { /* private */ }

    private func section(_ title: String) -> some View { /* private */ }

    // MARK: - Tabs

    private var trading: some View { /* private */ }

    private func addSymbol() { /* private */ }

    private var strategy: some View { /* private */ }

    private var degiro: some View { /* private */ }

    @ViewBuilder
    private func degiroStatus(_ g: DegiroInfo?) -> some View { /* private */ }

    @ViewBuilder
    private func login(_ g: DegiroInfo?) -> some View { /* private */ }

    private var alerts: some View { /* private */ }

    private func connection(_ disconnect: @escaping () -> Void) -> some View { /* private */ }
}

/// Settings → Phone: turn phone access on, show the QR code and the pairing link.
@MainActor
struct PhoneAccessView: View {
    @ObservedObject var store: DashboardStore

    var body: some View { /* private */ }

    @ViewBuilder
    private var content: some View { /* private */ }
}

/// A QR code for a link (CoreImage), on a white square.
@MainActor
struct QRCodeView: View {
    let text: String

    var body: some View { /* private */ }

    #if canImport(CoreImage)
    static func make(_ text: String) -> CGImage? { /* private */ }
    #endif
}

/// Copy and paste on both the Mac and the iPhone.
public enum Clipboard {
    public static func copy(_ text: String) { /* private */ }

    public static func read() -> String? { /* private */ }
}
