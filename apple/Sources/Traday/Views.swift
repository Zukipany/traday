// Source code is private. This file shows only its types and signatures.

import AppKit
import ServiceManagement
import SwiftUI
import TradayKit
import TradayUI

/// The native dashboard's state, shared by the window and the menu bar.
@MainActor
enum AppStores {
    static let dashboard: DashboardStore
}

// MARK: - Main window

@MainActor
struct ContentView: View {
    @EnvironmentObject var backend: Backend
    /// The web page instead of the native dashboard (both control the same traday).
    @AppStorage("webDashboard") private var webDashboard

    var body: some View { /* private */ }

    private func progress(_ title: String, detail: String) -> some View { /* private */ }
}

struct LogView: View {
    let text: String

    var body: some View { /* private */ }
}

// MARK: - Menu bar

@MainActor
struct MenuView: View {
    @EnvironmentObject var backend: Backend
    @EnvironmentObject var status: StatusModel
    @Environment(\.openWindow) private var openWindow

    var body: some View { /* private */ }

    private func showDashboard() { /* private */ }

    /// The native dashboard's Settings → Phone: QR code and pairing link for the iPhone.
    private func showPhoneAccess() { /* private */ }

    private func act(_ path: String) { /* private */ }
}

// MARK: - Settings window

@MainActor
struct SettingsView: View {
    @EnvironmentObject var backend: Backend
    @AppStorage("keepAwake") private var keepAwake
    @AppStorage("autoStartBot") private var autoStartBot
    @AppStorage("autoStartLive") private var autoStartLive
    @State private var launchAtLogin
    @State private var username
    @State private var password
    @State private var totp
    @State private var account
    @State private var message

    var body: some View { /* private */ }

    private var general: some View { /* private */ }

    private var degiro: some View { /* private */ }

    private func load() { /* private */ }

    private func save() { /* private */ }

    private func remove() { /* private */ }

    private func setLaunchAtLogin(_ on: Bool) { /* private */ }
}
