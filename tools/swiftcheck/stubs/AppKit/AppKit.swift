// Source code is private. This file shows only its types and signatures.

@_exported import Foundation
#if canImport(FoundationNetworking)
@_exported import FoundationNetworking
#endif

public final class NSPasteboard {
    public struct PasteboardType: Hashable, RawRepresentable {
        public var rawValue: String
        public init(rawValue: String) { /* private */ }
        public init(_ rawValue: String) { /* private */ }
        public static let string
    }
    public static let general
    @discardableResult public func clearContents() -> Int { /* private */ }
    @discardableResult public func setString(_ string: String, forType dataType: PasteboardType) -> Bool { /* private */ }
    public func string(forType dataType: PasteboardType) -> String? { /* private */ }
}

open class NSResponder: NSObject {}
open class NSView: NSResponder {
    public override init() { /* private */ }
    public init(frame: CGRect) { /* private */ }
}

public final class NSColor: NSObject {
    public static let textBackgroundColor
}

public final class NSButton: NSView {}

public protocol NSApplicationDelegate: NSObjectProtocol {}

public final class NSApplication: NSResponder {
    public enum TerminateReply: UInt { case terminateCancel , terminateNow , terminateLater }
    public struct ModalResponse: Equatable, RawRepresentable {
        public var rawValue: Int
        public init(rawValue: Int) { /* private */ }
        public static let OK
        public static let cancel
        public static let alertFirstButtonReturn
        public static let alertSecondButtonReturn
    }
    public static let shared
    public func activate(ignoringOtherApps flag: Bool) { /* private */ }
    public func terminate(_ sender: Any?) { /* private */ }
    public func reply(toApplicationShouldTerminate shouldTerminate: Bool) { /* private */ }
    @discardableResult public func sendAction(_ action: Selector, to target: Any?, from sender: Any?) -> Bool { /* private */ }
}

@MainActor public var NSApp: NSApplication { /* private */ }

public final class NSAlert: NSObject {
    public var messageText
    public var informativeText
    @discardableResult public func addButton(withTitle title: String) -> NSButton { /* private */ }
    public func runModal() -> NSApplication.ModalResponse { /* private */ }
}

public final class NSOpenPanel: NSObject {
    public var canChooseDirectories
    public var canChooseFiles
    public var allowsMultipleSelection
    public var prompt: String?
    public var message: String?
    public var url: URL? { /* private */ }
    public func runModal() -> NSApplication.ModalResponse { /* private */ }
}

public final class NSWorkspace: NSObject {
    public static let shared
    @discardableResult public func open(_ url: URL) -> Bool { /* private */ }
}

#if os(Linux)
public struct Selector: Hashable {
    public init(_ name: String) { /* private */ }
}
#endif

#if os(Linux)
extension ProcessInfo {
    public struct ActivityOptions: OptionSet {
        public let rawValue: UInt64
        public init(rawValue: UInt64) { /* private */ }
        public static let idleSystemSleepDisabled
        public static let userInitiated
    }
    public func beginActivity(options: ActivityOptions = [], reason: String) -> NSObjectProtocol { /* private */ }
    public func endActivity(_ activity: NSObjectProtocol) { /* private */ }
}
#endif
