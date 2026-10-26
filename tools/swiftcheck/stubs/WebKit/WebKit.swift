// Source code is private. This file shows only its types and signatures.

import AppKit

public final class WKWebsiteDataStore: NSObject {
    public static func nonPersistent() -> WKWebsiteDataStore { /* private */ }
    public static func `default`() -> WKWebsiteDataStore { /* private */ }
}

public final class WKWebViewConfiguration: NSObject {
    public var websiteDataStore
}

public final class WKNavigation: NSObject {}
public final class WKWindowFeatures: NSObject {}
public final class WKFrameInfo: NSObject {}
public final class WKNavigationAction: NSObject {
    public var request: URLRequest { /* private */ }
}
public enum WKNavigationActionPolicy: Int { case cancel, allow, download }

public protocol WKUIDelegate: NSObjectProtocol {}
public protocol WKNavigationDelegate: NSObjectProtocol {}

open class WKWebView: NSView {
    public init(frame: CGRect, configuration: WKWebViewConfiguration) { /* private */ }
    public weak var uiDelegate: WKUIDelegate?
    public weak var navigationDelegate: WKNavigationDelegate?
    public var allowsBackForwardNavigationGestures
    @discardableResult public func load(_ request: URLRequest) -> WKNavigation? { /* private */ }
    @discardableResult public func reload() -> WKNavigation? { /* private */ }
}
