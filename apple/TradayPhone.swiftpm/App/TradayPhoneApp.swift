// Source code is private. This file shows only its types and signatures.

import Security
import SwiftUI
import TradayKit
import TradayUI

/// traday on the iPhone: the native dashboard, connected to the traday on your Mac through
/// Tailscale with the pairing link from Settings → Phone.
@main
@MainActor
struct TradayPhoneApp: App {
    @StateObject private var connection

    var body: some Scene { /* private */ }
}

/// Which Mac this phone talks to (kept in the iPhone's Keychain).
@MainActor
final class PhoneConnection: ObservableObject {
    @Published private(set) var store: DashboardStore?

    init() { /* private */ }

    func connect(_ pairing: Pairing, save: Bool = true) { /* private */ }

    func forget() { /* private */ }
}

@MainActor
struct RootView: View {
    @EnvironmentObject var connection: PhoneConnection

    var body: some View { /* private */ }
}

/// The dashboard, or a way back to pairing when the Mac made a new pairing code.
@MainActor
struct PairedView: View {
    @ObservedObject var store: DashboardStore
    @EnvironmentObject var connection: PhoneConnection

    var body: some View { /* private */ }
}

/// First start: scan the pairing QR code on the Mac (or paste its link).
@MainActor
struct ConnectView: View {
    @EnvironmentObject var connection: PhoneConnection
    @State private var link
    @State private var checking
    @State private var scanning
    @State private var error

    var body: some View { /* private */ }

    private func connect() async { /* private */ }
}

/// The pairing link lives in the iPhone's Keychain, readable only by this app on this phone.
enum PhoneKeychain {
    static let service

    private static func query(_ account: String) -> [String: Any] { /* private */ }

    private static func get(_ account: String) -> String? { /* private */ }

    private static func set(_ account: String, _ value: String) { /* private */ }

    static func load() -> Pairing? { /* private */ }

    static func save(_ pairing: Pairing) { /* private */ }

    static func clear() { /* private */ }
}
