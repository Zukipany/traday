// Source code is private. This file shows only its types and signatures.

import AppKit
import Combine
import Foundation

/// Starts the Python traday dashboard (`.venv/bin/traday dashboard`) from the traday folder,
/// installs it the first time, restarts it if it crashes and stops it cleanly on quit.
@MainActor
final class Backend: ObservableObject {
    static let shared

    enum State: Equatable {
        case stopped
        case needsFolder
        case settingUp(String)
        case starting
        case running
        case failed(String)
    }

    @Published private(set) var state: State
    @Published private(set) var log
    @Published private(set) var reloadToken
    /// True when another traday dashboard (e.g. started in Terminal) was already serving the port.
    @Published private(set) var attached

    let port
    var baseURL: URL { /* private */ }
    var dashboardURL: URL { /* private */ }

    private var process: Process?
    private var launching
    private var stopping
    private var restarts: [Date]
    private var activity: NSObjectProtocol?

    // MARK: - The traday folder

    /// The folder chosen in the app, else the one build-app.sh wrote into Info.plist.
    var folder: URL? { /* private */ }

    nonisolated static func isTradayFolder(_ url: URL) -> Bool { /* private */ }

    func setFolder(_ url: URL) { /* private */ }

    // MARK: - Start and stop

    func start() { /* private */ }

    func restart() { /* private */ }

    /// Stops traday and waits (up to 8 s) so its bot can shut down cleanly.
    func stopAndWait() { /* private */ }

    /// Runs the first-time setup again (for example after updating traday from GitHub).
    func reinstall() { /* private */ }

    private func launch(in folder: URL) async { /* private */ }

    private func processEnded(_ code: Int32) { /* private */ }

    func append(_ text: String) { /* private */ }

    /// Does something answer like the traday dashboard on our port?
    func isServing() async -> Bool { /* private */ }

    // MARK: - Environment and secrets

    private func environment() -> [String: String] { /* private */ }

    // MARK: - Keep the Mac awake

    private func beginActivity() { /* private */ }

    private func endActivity() { /* private */ }

    func keepAwakeChanged() { /* private */ }

    // MARK: - First-time setup

    private func setUp(_ folder: URL) async -> Bool { /* private */ }

    nonisolated static func findPython() async -> String? { /* private */ }

    /// Runs a program to the end on a background queue and returns its exit code and output.
    nonisolated static func run(_ exe: String, _ args: [String], in dir: URL?,
                                env: [String: String]?) async -> (Int32, String) { /* private */ }
}
