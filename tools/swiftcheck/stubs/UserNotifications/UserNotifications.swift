// Source code is private. This file shows only its types and signatures.

import Foundation

public struct UNAuthorizationOptions: OptionSet {
    public let rawValue: UInt
    public init(rawValue: UInt) { /* private */ }
    public static let badge
    public static let sound
    public static let alert
}

public final class UNNotificationSound: NSObject {
    public static let `default`
}

public class UNNotificationContent: NSObject {}

public final class UNMutableNotificationContent: UNNotificationContent {
    public var title
    public var body
    public var sound: UNNotificationSound?
}

public class UNNotificationTrigger: NSObject {}

public final class UNNotificationRequest: NSObject {
    public init(identifier: String, content: UNNotificationContent, trigger: UNNotificationTrigger?) { /* private */ }
}

public final class UNUserNotificationCenter: NSObject {
    public static func current() -> UNUserNotificationCenter { /* private */ }
    public func requestAuthorization(options: UNAuthorizationOptions = [], completionHandler: @escaping (Bool, Error?) -> Void) { /* private */ }
    public func add(_ request: UNNotificationRequest, withCompletionHandler completionHandler: ((Error?) -> Void)? = nil) { /* private */ }
}
