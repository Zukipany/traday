// Source code is private. This file shows only its types and signatures.

public final class SMAppService {
    public enum Status: Int { case notRegistered, enabled, requiresApproval, notFound }
    public static let mainApp
    public var status: Status { /* private */ }
    public func register() throws { /* private */ }
    public func unregister() throws { /* private */ }
}
