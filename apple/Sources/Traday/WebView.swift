// Source code is private. This file shows only its types and signatures.

import AppKit
import SwiftUI
import WebKit

/// The traday dashboard page inside the app window.
struct DashboardWebView: NSViewRepresentable {
    let url: URL
    let reloadToken: Int

    func makeCoordinator() -> Coordinator { /* private */ }

    func makeNSView(context: Context) -> WKWebView { /* private */ }

    func updateNSView(_ view: WKWebView, context: Context) { /* private */ }

    final class Coordinator: NSObject {
        var token
    }
}

extension DashboardWebView.Coordinator: WKUIDelegate, WKNavigationDelegate {
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration,
                 for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? { /* private */ }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) { /* private */ }

    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String,
                 initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) { /* private */ }

    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String,
                 initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) { /* private */ }
}
