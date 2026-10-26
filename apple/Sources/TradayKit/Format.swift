// Source code is private. This file shows only its types and signatures.

import Foundation

/// Numbers the way the web dashboard writes them.
public enum Fmt {
    private static func grouped(_ x: Double, digits: Int) -> String { /* private */ }

    /// "182.93", or "–" when missing.
    public static func price(_ x: Double?) -> String { /* private */ }

    /// "$1,234.56"; with sign: "+$10.00" / "−$20.76" (a real minus sign, like the web page).
    public static func money(_ x: Double?, sign: Bool = false) -> String { /* private */ }

    /// An amount in the account's own currency (DEGIRO reports EUR): "3,187.42".
    public static func amount(_ x: Double?) -> String { /* private */ }

    /// Share counts: "13", or "2.5" for fractions.
    public static func qty(_ x: Double) -> String { /* private */ }

    /// "62.8%".
    public static func pct(_ x: Double, digits: Int = 1) -> String { /* private */ }

    /// "10,000".
    public static func count(_ n: Int) -> String { /* private */ }

    /// "+0.1R" / "−0.2R".
    public static func r(_ x: Double) -> String { /* private */ }
}
