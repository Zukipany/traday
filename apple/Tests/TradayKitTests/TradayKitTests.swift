// Source code is private. This file shows only its types and signatures.

import Foundation
import XCTest
@testable import TradayKit

/// Fixtures are real answers of the dashboard server (tools/screenshots/server.py: made-up prices,
/// a pretend DEGIRO account, a fake Tailscale name), so these tests check the app reads exactly
/// what the server sends.
func fixture(_ name: String) throws -> Data { /* private */ }

func decode<T: Decodable>(_ type: T.Type, _ name: String) throws -> T { /* private */ }

final class DecodingTests: XCTestCase {
    func testStatusPaperLiveAndDemo() throws { /* private */ }

    func testScanChartJournalReplay() throws { /* private */ }

    func testSettingsRemoteAndSearch() throws { /* private */ }

    func testNewsAndTolerantDecoding() throws { /* private */ }
}

final class TimeAndFormatTests: XCTestCase {
    func testParsing() throws { /* private */ }

    func testMoneyAndPrices() { /* private */ }
}

final class LabelTests: XCTestCase {
    func testWordsMatchTheWebPage() throws { /* private */ }

    func testPlanStrip() throws { /* private */ }

    func testFeedWordsForEveryEvent() { /* private */ }
}

final class ChartModelTests: XCTestCase {
    func testGeometry() throws { /* private */ }

    func testNiceSteps() { /* private */ }
}

final class SettingsFormTests: XCTestCase {
    func testEditAndSaveLikeTheWebPage() throws { /* private */ }
}

final class ClientTests: XCTestCase {
    func testRequestsLookLikeThePage() throws { /* private */ }

    func testPairingLinks() { /* private */ }

    func testJSONValueRoundTrip() throws { /* private */ }

    func testAgentsAndTheirPixels() throws { /* private */ }

    func testPosesMoveLikeTheWebPage() { /* private */ }

    func testTheReelTradeStory() throws { /* private */ }

    func testTradeHistory() throws { /* private */ }
}
