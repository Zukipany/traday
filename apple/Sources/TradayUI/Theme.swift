// Source code is private. This file shows only its types and signatures.

import SwiftUI
import TradayKit

/// The web dashboard's colours, so both look alike.
public enum Palette {
    static func hex(_ v: UInt32, _ alpha: Double = 1) -> Color { /* private */ }

    public static let bg
    public static let panel
    public static let panel2
    public static let line
    public static let line2
    public static let text
    public static let muted
    public static let faint
    public static let green
    public static let greenText
    public static let red
    public static let redText
    public static let blue
    public static let blueText
    public static let amber
    public static let slate
    public static let grid
    public static let primary
    public static let danger
    public static let dangerDim

    public static func tone(_ t: Tone) -> Color { /* private */ }

    /// Profit green, loss red, zero plain.
    public static func pnl(_ x: Double) -> Color { /* private */ }
}

/// A rounded pill: "breakout", "open", ...
@MainActor
struct Pill: View {
    let text: String
    let tone: Tone

    init(_ text: String, _ tone: Tone) { /* private */ }

    var body: some View { /* private */ }
}

/// A dashboard panel with an upper-case title.
@MainActor
struct Card<Content: View>: View {
    let title: String
    let note: String
    let content: Content

    init(_ title: String, note: String = "", @ViewBuilder content: () -> Content) { /* private */ }

    var body: some View { /* private */ }
}

/// A label/value row, the value right-aligned.
@MainActor
struct KeyValue: View {
    let key: String
    let value: String
    var color: Color

    var body: some View { /* private */ }
}

/// Number keyboards on the iPhone; nothing to do on the Mac.
extension View {
    func decimalKeyboard() -> some View { /* private */ }

    func plainTextEntry() -> some View { /* private */ }
}
