// Source code is private. This file shows only its types and signatures.

public protocol ObservableObject: AnyObject {}

@propertyWrapper
public struct Published<Value> {
    public var wrappedValue: Value
    public init(wrappedValue: Value) { /* private */ }
}

public final class AnyCancellable {
    public init() { /* private */ }
}
