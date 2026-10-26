// Source code is private. This file shows only its types and signatures.

import AppKit
import SwiftUI

/// traday for Mac: the dashboard in a native window, a menu bar item that is always there,
/// the DEGIRO login in the Keychain, notifications, keep-awake and open-at-login.
/// The trading itself is the same Python program as everywhere else; this app starts it,
/// keeps it running and shows it.
@main
@MainActor
struct TradayApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    @StateObject private var backend
    @StateObject private var status

    var body: some Scene { /* private */ }
}

final class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) { /* private */ }

    /// Closing the window keeps traday running in the menu bar.
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool { /* private */ }

    /// Quit only after the Python program (and its bot) has shut down.
    func applicationShouldTerminate(_ sender: NSApplication) -> NSApplication.TerminateReply { /* private */ }
}

/// Opens the system Settings window of this app (works on macOS 13 and later).
@MainActor
func openAppSettings() { /* private */ }

@MainActor
func showAlert(_ title: String, _ text: String = "") { /* private */ }

@MainActor
func chooseFolder(_ backend: Backend) { /* private */ }
