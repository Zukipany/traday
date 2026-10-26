// Source code is private. This file shows only its types and signatures.

@_exported import Combine
@_exported import Foundation
#if canImport(UIKit)
import UIKit
#endif

// MARK: - View and builders

public protocol View {
    associatedtype Body: View
    @ViewBuilder @MainActor var body: Self.Body { get }
}

extension Never: View {
    public var body: Never { /* private */ }
}

public protocol _Primitive: View where Body == Never {}
extension _Primitive {
    public var body: Never { /* private */ }
}

public struct EmptyView: _Primitive { public init() { /* private */ }}
public struct TupleView<T>: _Primitive {
    public var value: T
    public init(_ value: T) { /* private */ }
}
public struct _ConditionalContent<TrueContent: View, FalseContent: View>: _Primitive {}
public struct AnyView: _Primitive {
    public init<V: View>(_ view: V) { /* private */ }
}
extension Optional: View where Wrapped: View {
    public var body: Never { /* private */ }
}

@resultBuilder
public struct ViewBuilder {
    public static func buildBlock() -> EmptyView { /* private */ }
    public static func buildBlock<Content: View>(_ content: Content) -> Content { /* private */ }
    public static func buildBlock<each Content: View>(_ content: repeat each Content) -> TupleView<(repeat each Content)> { /* private */ }
    public static func buildExpression<Content: View>(_ content: Content) -> Content { /* private */ }
    public static func buildIf<Content: View>(_ content: Content?) -> Content? { /* private */ }
    public static func buildEither<T: View, F: View>(first: T) -> _ConditionalContent<T, F> { /* private */ }
    public static func buildEither<T: View, F: View>(second: F) -> _ConditionalContent<T, F> { /* private */ }
    public static func buildLimitedAvailability<Content: View>(_ content: Content) -> AnyView { /* private */ }
}

public protocol DynamicProperty {}

// MARK: - State and bindings

@propertyWrapper
@dynamicMemberLookup
public struct Binding<Value> {
    private let getter: () -> Value
    private let setter: (Value) -> Void
    public init(get: @escaping () -> Value, set: @escaping (Value) -> Void) { /* private */ }
    public init(projectedValue: Binding<Value>) { /* private */ }
    public static func constant(_ value: Value) -> Binding<Value> { /* private */ }
    public var wrappedValue: Value {
        get { /* private */ }
        nonmutating set { /* private */ }
    }
    public var projectedValue: Binding<Value> { /* private */ }
    public subscript<Subject>(dynamicMember keyPath: WritableKeyPath<Value, Subject>) -> Binding<Subject> { /* private */ }
}

final class _Box<Value> {
    var value: Value
    init(_ value: Value) { /* private */ }
}

@propertyWrapper
public struct State<Value>: DynamicProperty {
    private let box: _Box<Value>
    public init(wrappedValue value: Value) { /* private */ }
    public init(initialValue value: Value) { /* private */ }
    public var wrappedValue: Value {
        get { /* private */ }
        nonmutating set { /* private */ }
    }
    public var projectedValue: Binding<Value> { /* private */ }
}

@propertyWrapper
public struct ObservedObject<ObjectType: ObservableObject>: DynamicProperty {
    @dynamicMemberLookup
    public struct Wrapper {
        let root: ObjectType
        public subscript<Subject>(dynamicMember keyPath: ReferenceWritableKeyPath<ObjectType, Subject>) -> Binding<Subject> { /* private */ }
    }
    public var wrappedValue: ObjectType
    public init(wrappedValue: ObjectType) { /* private */ }
    public init(initialValue: ObjectType) { /* private */ }
    public var projectedValue: Wrapper { /* private */ }
}

@propertyWrapper
public struct StateObject<ObjectType: ObservableObject>: DynamicProperty {
    public init(wrappedValue thunk: @autoclosure @escaping () -> ObjectType) { /* private */ }
    public var wrappedValue: ObjectType
    public var projectedValue: ObservedObject<ObjectType>.Wrapper { /* private */ }
}

@propertyWrapper
public struct EnvironmentObject<ObjectType: ObservableObject>: DynamicProperty {
    public init() { /* private */ }
    public var wrappedValue: ObjectType { /* private */ }
    public var projectedValue: ObservedObject<ObjectType>.Wrapper { /* private */ }
}

// MARK: - Basic types

public enum ColorScheme: Hashable, CaseIterable { case light, dark }
public enum ControlSize: Hashable { case mini, small, regular, large }
public enum TextAlignment: Hashable { case leading, center, trailing }
public enum Visibility: Hashable { case automatic, visible, hidden }
public enum ButtonRole: Hashable { case destructive, cancel }

public struct Edge {
    public struct Set: OptionSet, Hashable {
        public let rawValue: Int8
        public init(rawValue: Int8) { /* private */ }
        public static let top
        public static let leading
        public static let bottom
        public static let trailing
        public static let horizontal: Set
        public static let vertical: Set
        public static let all: Set
    }
}

public enum Axis: Hashable {
    case horizontal, vertical
    public struct Set: OptionSet, Hashable {
        public let rawValue: Int8
        public init(rawValue: Int8) { /* private */ }
        public static let horizontal
        public static let vertical
    }
}

public struct HorizontalAlignment: Equatable {
    public static let leading
    public static let center
    public static let trailing
}

public struct VerticalAlignment: Equatable {
    public static let top
    public static let center
    public static let bottom
    public static let firstTextBaseline
    public static let lastTextBaseline
}

public struct Alignment: Equatable {
    public var horizontal: HorizontalAlignment
    public var vertical: VerticalAlignment
    public init(horizontal: HorizontalAlignment, vertical: VerticalAlignment) { /* private */ }
    public static let center
    public static let leading
    public static let trailing
    public static let top
    public static let bottom
    public static let topLeading
    public static let topTrailing
    public static let bottomLeading
    public static let bottomTrailing
}

public struct UnitPoint: Hashable {
    public var x: CGFloat
    public var y: CGFloat
    public init(x: CGFloat, y: CGFloat) { /* private */ }
    public static let zero
    public static let center
    public static let leading
    public static let trailing
    public static let top
    public static let bottom
    public static let topLeading
    public static let topTrailing
    public static let bottomLeading
    public static let bottomTrailing
}

public struct EdgeInsets: Equatable {
    public var top, leading, bottom, trailing: CGFloat
    public init(top: CGFloat = 0, leading: CGFloat = 0, bottom: CGFloat = 0, trailing: CGFloat = 0) { /* private */ }
}

public struct LocalizedStringKey: Equatable, ExpressibleByStringLiteral, ExpressibleByStringInterpolation {
    public init(_ value: String) { /* private */ }
    public init(stringLiteral value: String) { /* private */ }
    public init(stringInterpolation: DefaultStringInterpolation) { /* private */ }
}

// MARK: - Colours, fonts, styles

public protocol ShapeStyle {}

public struct Color: _Primitive, ShapeStyle, Hashable {
    public enum RGBColorSpace: Hashable { case sRGB, sRGBLinear, displayP3 }
    public init(_ colorSpace: RGBColorSpace = .sRGB, red: Double, green: Double, blue: Double, opacity: Double = 1) { /* private */ }
    public init(_ colorSpace: RGBColorSpace = .sRGB, white: Double, opacity: Double = 1) { /* private */ }
    public func opacity(_ opacity: Double) -> Color { /* private */ }
    public static let white
    public static let black
    public static let clear
    public static let gray
    public static let red
    public static let green
    public static let blue
    public static let orange
    public static let yellow
    public static let primary
    public static let secondary
    public static let accentColor
}

public struct LinearGradient: _Primitive, ShapeStyle {
    public init(colors: [Color], startPoint: UnitPoint, endPoint: UnitPoint) { /* private */ }
}

public struct HierarchicalShapeStyle: ShapeStyle {
    public static let primary
    public static let secondary
    public static let tertiary
}

extension ShapeStyle where Self == HierarchicalShapeStyle {
    public static var primary: HierarchicalShapeStyle { /* private */ }
    public static var secondary: HierarchicalShapeStyle { /* private */ }
    public static var tertiary: HierarchicalShapeStyle { /* private */ }
}

public struct Font: Hashable {
    public enum Design: Hashable { case `default`, serif, rounded, monospaced }
    public struct Weight: Hashable {
        public static let ultraLight , thin , light , regular , medium
        public static let semibold , bold , heavy , black
    }
    public enum TextStyle: Hashable { case largeTitle, title, title2, title3, headline, subheadline, body, callout, footnote, caption, caption2 }
    public static func system(size: CGFloat, weight: Font.Weight? = nil, design: Font.Design? = nil) -> Font { /* private */ }
    public static func system(_ style: Font.TextStyle, design: Font.Design? = nil, weight: Font.Weight? = nil) -> Font { /* private */ }
    public static let largeTitle , title , title2 , title3 , headline
    public static let subheadline , body , callout , footnote , caption , caption2
    public func monospacedDigit() -> Font { /* private */ }
    public func monospaced() -> Font { /* private */ }
    public func bold() -> Font { /* private */ }
    public func weight(_ weight: Font.Weight) -> Font { /* private */ }
}

public struct StrokeStyle: Hashable {
    public enum LineCap: Hashable { case butt, round, square }
    public enum LineJoin: Hashable { case miter, round, bevel }
    public var lineWidth: CGFloat
    public var dash: [CGFloat]
    public init(lineWidth: CGFloat = 1, lineCap: LineCap = .butt, lineJoin: LineJoin = .miter, miterLimit: CGFloat = 10,
                dash: [CGFloat] = [], dashPhase: CGFloat = 0) { /* private */ }
}

public struct FillStyle: Equatable {
    public init(eoFill: Bool = false, antialiased: Bool = true) { /* private */ }
}

// MARK: - Views

public struct Text: _Primitive, Equatable {
    public init(_ key: LocalizedStringKey) { /* private */ }
    public init<S: StringProtocol>(_ content: S) { /* private */ }
    public init(verbatim content: String) { /* private */ }
    public static func + (lhs: Text, rhs: Text) -> Text { /* private */ }
    public func font(_ font: Font?) -> Text { /* private */ }
    public func fontWeight(_ weight: Font.Weight?) -> Text { /* private */ }
    public func bold() -> Text { /* private */ }
    public func bold(_ isActive: Bool) -> Text { /* private */ }
    public func italic() -> Text { /* private */ }
    public func monospacedDigit() -> Text { /* private */ }
    public func kerning(_ kerning: CGFloat) -> Text { /* private */ }
    public func tracking(_ tracking: CGFloat) -> Text { /* private */ }
    public func foregroundColor(_ color: Color?) -> Text { /* private */ }
    public func underline(_ isActive: Bool = true, color: Color? = nil) -> Text { /* private */ }
}

public struct Image: _Primitive {
    public enum Interpolation: Hashable { case none, low, medium, high }
    public init(systemName: String) { /* private */ }
    public init(_ name: String) { /* private */ }
    public func resizable() -> Image { /* private */ }
    public func interpolation(_ interpolation: Interpolation) -> Image { /* private */ }
}

public struct Spacer: _Primitive { public init(minLength: CGFloat? = nil) { /* private */ }}
public struct Divider: _Primitive { public init() { /* private */ }}

public struct HStack<Content: View>: _Primitive {
    public init(alignment: VerticalAlignment = .center, spacing: CGFloat? = nil, @ViewBuilder content: () -> Content) { /* private */ }
}

public struct VStack<Content: View>: _Primitive {
    public init(alignment: HorizontalAlignment = .center, spacing: CGFloat? = nil, @ViewBuilder content: () -> Content) { /* private */ }
}

public struct ZStack<Content: View>: _Primitive {
    public init(alignment: Alignment = .center, @ViewBuilder content: () -> Content) { /* private */ }
}

public struct ScrollView<Content: View>: _Primitive {
    public init(_ axes: Axis.Set = .vertical, showsIndicators: Bool = true, @ViewBuilder content: () -> Content) { /* private */ }
}

public struct PinnedScrollableViews: OptionSet {
    public let rawValue: UInt32
    public init(rawValue: UInt32) { /* private */ }
}

public struct GridItem {
    public enum Size {
        case fixed(CGFloat)
        case flexible(minimum: CGFloat = 10, maximum: CGFloat = .infinity)
        case adaptive(minimum: CGFloat, maximum: CGFloat = .infinity)
    }
    public init(_ size: GridItem.Size = .flexible(), spacing: CGFloat? = nil, alignment: Alignment? = nil) { /* private */ }
}

public struct LazyVGrid<Content: View>: _Primitive {
    public init(columns: [GridItem], alignment: HorizontalAlignment = .center, spacing: CGFloat? = nil,
                pinnedViews: PinnedScrollableViews = .init(), @ViewBuilder content: () -> Content) { /* private */ }
}

public struct ForEach<Data: RandomAccessCollection, ID: Hashable, Content> {
    public var data: Data
    public init(_data data: Data) { /* private */ }
}

extension ForEach: View, _Primitive where Content: View {
    public init(_ data: Data, @ViewBuilder content: @escaping (Data.Element) -> Content)
        where ID == Data.Element.ID, Data.Element: Identifiable { /* private */ }
    public init(_ data: Data, id: KeyPath<Data.Element, ID>, @ViewBuilder content: @escaping (Data.Element) -> Content) { /* private */ }
    public init(_ data: Range<Int>, @ViewBuilder content: @escaping (Int) -> Content) where Data == Range<Int>, ID == Int { /* private */ }
}

public struct Group<Content> {
    public init(_content: Void) { /* private */ }
}

extension Group: View, _Primitive where Content: View {
    public init(@ViewBuilder content: () -> Content) { /* private */ }
}

public struct Button<Label: View>: _Primitive {
    public init(action: @escaping () -> Void, @ViewBuilder label: () -> Label) { /* private */ }
    public init(role: ButtonRole?, action: @escaping () -> Void, @ViewBuilder label: () -> Label) { /* private */ }
}

extension Button where Label == Text {
    public init(_ titleKey: LocalizedStringKey, action: @escaping () -> Void) { /* private */ }
    public init<S: StringProtocol>(_ title: S, action: @escaping () -> Void) { /* private */ }
    public init(_ titleKey: LocalizedStringKey, role: ButtonRole?, action: @escaping () -> Void) { /* private */ }
    public init<S: StringProtocol>(_ title: S, role: ButtonRole?, action: @escaping () -> Void) { /* private */ }
}

public struct Picker<Label: View, SelectionValue: Hashable, Content: View>: _Primitive {
    public init(selection: Binding<SelectionValue>, @ViewBuilder content: () -> Content, @ViewBuilder label: () -> Label) { /* private */ }
}

extension Picker where Label == Text {
    public init(_ titleKey: LocalizedStringKey, selection: Binding<SelectionValue>, @ViewBuilder content: () -> Content) { /* private */ }
    public init<S: StringProtocol>(_ title: S, selection: Binding<SelectionValue>, @ViewBuilder content: () -> Content) { /* private */ }
}

public struct Toggle<Label: View>: _Primitive {
    public init(isOn: Binding<Bool>, @ViewBuilder label: () -> Label) { /* private */ }
}

extension Toggle where Label == Text {
    public init(_ titleKey: LocalizedStringKey, isOn: Binding<Bool>) { /* private */ }
    public init<S: StringProtocol>(_ title: S, isOn: Binding<Bool>) { /* private */ }
}

public struct TextField<Label: View>: _Primitive {}

extension TextField where Label == Text {
    public init(_ titleKey: LocalizedStringKey, text: Binding<String>) { /* private */ }
    public init<S: StringProtocol>(_ title: S, text: Binding<String>) { /* private */ }
    public init(_ titleKey: LocalizedStringKey, text: Binding<String>, prompt: Text?) { /* private */ }
    public init<S: StringProtocol>(_ title: S, text: Binding<String>, prompt: Text?) { /* private */ }
}

public struct SecureField<Label: View>: _Primitive {}

extension SecureField where Label == Text {
    public init(_ titleKey: LocalizedStringKey, text: Binding<String>) { /* private */ }
    public init<S: StringProtocol>(_ title: S, text: Binding<String>) { /* private */ }
}

public struct Link<Label: View>: _Primitive {
    public init(destination: URL, @ViewBuilder label: () -> Label) { /* private */ }
}

extension Link where Label == Text {
    public init(_ titleKey: LocalizedStringKey, destination: URL) { /* private */ }
    public init<S: StringProtocol>(_ title: S, destination: URL) { /* private */ }
}

public struct Label<Title: View, Icon: View>: _Primitive {
    public init(@ViewBuilder title: () -> Title, @ViewBuilder icon: () -> Icon) { /* private */ }
}

extension Label where Title == Text, Icon == Image {
    public init(_ titleKey: LocalizedStringKey, systemImage name: String) { /* private */ }
    public init<S: StringProtocol>(_ title: S, systemImage name: String) { /* private */ }
}

public struct ProgressView<Label: View, CurrentValueLabel: View>: _Primitive {}

extension ProgressView where Label == EmptyView, CurrentValueLabel == EmptyView {
    public init() { /* private */ }
    public init<V: BinaryFloatingPoint>(value: V?, total: V = 1.0) { /* private */ }
}

public struct GeometryProxy {
    public var size: CGSize { /* private */ }
}

public struct GeometryReader<Content: View>: _Primitive {
    public init(@ViewBuilder content: @escaping (GeometryProxy) -> Content) { /* private */ }
}

public struct NavigationStack<Root: View>: _Primitive {
    public init(@ViewBuilder root: () -> Root) { /* private */ }
}

public struct TabView<SelectionValue: Hashable, Content: View>: _Primitive {
    public init(selection: Binding<SelectionValue>?, @ViewBuilder content: () -> Content) { /* private */ }
}

extension TabView where SelectionValue == Int {
    public init(@ViewBuilder content: () -> Content) { /* private */ }
}

public struct Form<Content: View>: _Primitive {
    public init(@ViewBuilder content: () -> Content) { /* private */ }
}

public struct Section<Parent, Content, Footer> {
    public init(_unused: Void) { /* private */ }
}

extension Section: View, _Primitive where Parent: View, Content: View, Footer: View {}

extension Section where Parent == Text, Content: View, Footer == EmptyView {
    public init<S: StringProtocol>(_ title: S, @ViewBuilder content: () -> Content) { /* private */ }
    public init(_ titleKey: LocalizedStringKey, @ViewBuilder content: () -> Content) { /* private */ }
}

extension Section where Parent == EmptyView, Content: View, Footer == EmptyView {
    public init(@ViewBuilder content: () -> Content) { /* private */ }
}

// MARK: - Shapes

public protocol Shape: View {}
public protocol InsettableShape: Shape {}

extension Shape {
    public func fill<S: ShapeStyle>(_ content: S, style: FillStyle = FillStyle()) -> some View { /* private */ }
    public func stroke<S: ShapeStyle>(_ content: S, lineWidth: CGFloat = 1) -> some View { /* private */ }
    public func stroke<S: ShapeStyle>(_ content: S, style: StrokeStyle, antialiased: Bool = true) -> some View { /* private */ }
}

extension InsettableShape {
    public func strokeBorder<S: ShapeStyle>(_ content: S, lineWidth: CGFloat = 1, antialiased: Bool = true) -> some View { /* private */ }
}

public struct Rectangle: InsettableShape, _Primitive { public init() { /* private */ }}
public struct Circle: InsettableShape, _Primitive { public init() { /* private */ }}
public struct Capsule: InsettableShape, _Primitive { public init() { /* private */ }}
public enum RoundedCornerStyle: Hashable { case circular, continuous }
public struct RoundedRectangle: InsettableShape, _Primitive {
    public init(cornerRadius: CGFloat, style: RoundedCornerStyle = .circular) { /* private */ }
}

public struct Path: Shape, _Primitive {
    public init() { /* private */ }
    public init(_ callback: (inout Path) -> Void) { /* private */ }
    public init(_ rect: CGRect) { /* private */ }
    public init(ellipseIn rect: CGRect) { /* private */ }
    public mutating func move(to end: CGPoint) { /* private */ }
    public mutating func addLine(to end: CGPoint) { /* private */ }
    public mutating func closeSubpath() { /* private */ }
}

// MARK: - Drawing: Canvas and TimelineView (iOS 15 / macOS 12)

public enum ContentMode: Hashable, CaseIterable { case fit, fill }
public enum ColorRenderingMode: Hashable { case nonLinear, linear, extendedLinear }

public struct GraphicsContext {
    public var opacity: Double
    public struct Shading {
        public static func color(_ color: Color) -> GraphicsContext.Shading { /* private */ }
    }
    public func fill(_ path: Path, with shading: GraphicsContext.Shading, style: FillStyle = FillStyle()) { /* private */ }
    public func stroke(_ path: Path, with shading: GraphicsContext.Shading, style: StrokeStyle) { /* private */ }
    public func stroke(_ path: Path, with shading: GraphicsContext.Shading, lineWidth: CGFloat = 1) { /* private */ }
    public func draw(_ text: Text, at point: CGPoint, anchor: UnitPoint = .center) { /* private */ }
}

public struct Canvas<Symbols: View>: _Primitive {
    public init(opaque: Bool = false, colorMode: ColorRenderingMode = .nonLinear, rendersAsynchronously: Bool = false,
                renderer: @escaping (inout GraphicsContext, CGSize) -> Void, @ViewBuilder symbols: () -> Symbols) { /* private */ }
}

extension Canvas where Symbols == EmptyView {
    public init(opaque: Bool = false, colorMode: ColorRenderingMode = .nonLinear, rendersAsynchronously: Bool = false,
                renderer: @escaping (inout GraphicsContext, CGSize) -> Void) { /* private */ }
}

public protocol TimelineSchedule {}

public struct AnimationTimelineSchedule: TimelineSchedule {
    public init(minimumInterval: Double? = nil, paused: Bool = false) { /* private */ }
}

extension TimelineSchedule where Self == AnimationTimelineSchedule {
    public static var animation: AnimationTimelineSchedule { /* private */ }
    public static func animation(minimumInterval: Double? = nil, paused: Bool = false) -> AnimationTimelineSchedule { /* private */ }
}

public struct TimelineView<Schedule: TimelineSchedule, Content> {
    public struct Context {
        public enum Cadence: Comparable { case live, seconds, minutes }
        public let date: Date
        public let cadence: Cadence
    }
}

public struct EveryMinuteTimelineSchedule: TimelineSchedule {
    public init() { /* private */ }
}

public typealias TimelineViewDefaultContext = TimelineView<EveryMinuteTimelineSchedule, Never>.Context

extension TimelineView: View, _Primitive where Content: View {
    public init(_ schedule: Schedule, @ViewBuilder content: @escaping (TimelineViewDefaultContext) -> Content) { /* private */ }
}

// MARK: - Styles

public protocol PrimitiveButtonStyle {}
public struct BorderedButtonStyle: PrimitiveButtonStyle { public init() { /* private */ }}
public struct BorderedProminentButtonStyle: PrimitiveButtonStyle { public init() { /* private */ }}
public struct PlainButtonStyle: PrimitiveButtonStyle { public init() { /* private */ }}
public struct BorderlessButtonStyle: PrimitiveButtonStyle { public init() { /* private */ }}
extension PrimitiveButtonStyle where Self == BorderedButtonStyle { public static var bordered: BorderedButtonStyle { /* private */ }}
extension PrimitiveButtonStyle where Self == BorderedProminentButtonStyle {
    public static var borderedProminent: BorderedProminentButtonStyle { /* private */ }
}
extension PrimitiveButtonStyle where Self == PlainButtonStyle { public static var plain: PlainButtonStyle { /* private */ }}
extension PrimitiveButtonStyle where Self == BorderlessButtonStyle { public static var borderless: BorderlessButtonStyle { /* private */ }}

public protocol PickerStyle {}
public struct SegmentedPickerStyle: PickerStyle { public init() { /* private */ }}
public struct MenuPickerStyle: PickerStyle { public init() { /* private */ }}
extension PickerStyle where Self == SegmentedPickerStyle { public static var segmented: SegmentedPickerStyle { /* private */ }}
extension PickerStyle where Self == MenuPickerStyle { public static var menu: MenuPickerStyle { /* private */ }}

public protocol TextFieldStyle {}
public struct RoundedBorderTextFieldStyle: TextFieldStyle { public init() { /* private */ }}
public struct PlainTextFieldStyle: TextFieldStyle { public init() { /* private */ }}
extension TextFieldStyle where Self == RoundedBorderTextFieldStyle {
    public static var roundedBorder: RoundedBorderTextFieldStyle { /* private */ }
}
extension TextFieldStyle where Self == PlainTextFieldStyle { public static var plain: PlainTextFieldStyle { /* private */ }}

public protocol TextSelectability {}
public struct EnabledTextSelectability: TextSelectability {}
extension TextSelectability where Self == EnabledTextSelectability { public static var enabled: EnabledTextSelectability { /* private */ }}

public protocol FormStyle {}
public struct GroupedFormStyle: FormStyle { public init() { /* private */ }}
extension FormStyle where Self == GroupedFormStyle { public static var grouped: GroupedFormStyle { /* private */ }}

public struct KeyEquivalent: ExpressibleByExtendedGraphemeClusterLiteral {
    public init(extendedGraphemeClusterLiteral value: Character) { /* private */ }
    public init(_ character: Character) { /* private */ }
    public static let escape
    public static let `return`
}

public struct EventModifiers: OptionSet {
    public let rawValue: Int
    public init(rawValue: Int) { /* private */ }
    public static let command
    public static let shift
    public static let option
}

public struct KeyboardShortcut {
    public init(_ key: KeyEquivalent, modifiers: EventModifiers = .command) { /* private */ }
    public static let defaultAction
    public static let cancelAction
}

public struct SubmitTriggers: OptionSet {
    public let rawValue: Int
    public init(rawValue: Int) { /* private */ }
    public static let text
}

public struct SafeAreaRegions: OptionSet {
    public let rawValue: UInt
    public init(rawValue: UInt) { /* private */ }
    public static let all
}

#if canImport(UIKit)
public struct TextInputAutocapitalization {
    public static var never: TextInputAutocapitalization { /* private */ }
    public static var words: TextInputAutocapitalization { /* private */ }
    public static var sentences: TextInputAutocapitalization { /* private */ }
}
#endif

// MARK: - Modifiers

extension View {
    public func padding(_ insets: EdgeInsets) -> some View { /* private */ }
    public func padding(_ edges: Edge.Set = .all, _ length: CGFloat? = nil) -> some View { /* private */ }
    public func padding(_ length: CGFloat) -> some View { /* private */ }
    public func frame(width: CGFloat? = nil, height: CGFloat? = nil, alignment: Alignment = .center) -> some View { /* private */ }
    public func frame(minWidth: CGFloat? = nil, idealWidth: CGFloat? = nil, maxWidth: CGFloat? = nil, minHeight: CGFloat? = nil,
                      idealHeight: CGFloat? = nil, maxHeight: CGFloat? = nil, alignment: Alignment = .center) -> some View { /* private */ }
    @_disfavoredOverload
    public func background<Background: View>(_ background: Background, alignment: Alignment = .center) -> some View { /* private */ }
    public func background<S: ShapeStyle>(_ style: S, ignoresSafeAreaEdges edges: Edge.Set = .all) -> some View { /* private */ }
    public func background<V: View>(alignment: Alignment = .center, @ViewBuilder content: () -> V) -> some View { /* private */ }
    @_disfavoredOverload
    public func overlay<Overlay: View>(_ overlay: Overlay, alignment: Alignment = .center) -> some View { /* private */ }
    public func overlay<S: ShapeStyle>(_ style: S, ignoresSafeAreaEdges edges: Edge.Set = .all) -> some View { /* private */ }
    public func overlay<V: View>(alignment: Alignment = .center, @ViewBuilder content: () -> V) -> some View { /* private */ }
    public func foregroundStyle<S: ShapeStyle>(_ style: S) -> some View { /* private */ }
    public func foregroundColor(_ color: Color?) -> some View { /* private */ }
    public func font(_ font: Font?) -> some View { /* private */ }
    public func fontWeight(_ weight: Font.Weight?) -> some View { /* private */ }
    public func bold(_ isActive: Bool = true) -> some View { /* private */ }
    public func monospacedDigit() -> some View { /* private */ }
    public func kerning(_ kerning: CGFloat) -> some View { /* private */ }
    public func opacity(_ opacity: Double) -> some View { /* private */ }
    public func lineLimit(_ number: Int?) -> some View { /* private */ }
    public func multilineTextAlignment(_ alignment: TextAlignment) -> some View { /* private */ }
    public func fixedSize() -> some View { /* private */ }
    public func fixedSize(horizontal: Bool, vertical: Bool) -> some View { /* private */ }
    public func clipShape<S: Shape>(_ shape: S, style: FillStyle = FillStyle()) -> some View { /* private */ }
    public func contentShape<S: Shape>(_ shape: S, eoFill: Bool = false) -> some View { /* private */ }
    public func onTapGesture(count: Int = 1, perform action: @escaping () -> Void) -> some View { /* private */ }
    public func shadow(color: Color = Color(white: 0, opacity: 0.33), radius: CGFloat, x: CGFloat = 0, y: CGFloat = 0) -> some View { /* private */ }
    public func scaledToFit() -> some View { /* private */ }
    public func ignoresSafeArea(_ regions: SafeAreaRegions = .all, edges: Edge.Set = .all) -> some View { /* private */ }
    public func preferredColorScheme(_ colorScheme: ColorScheme?) -> some View { /* private */ }
    public func disabled(_ disabled: Bool) -> some View { /* private */ }
    public func help(_ textKey: LocalizedStringKey) -> some View { /* private */ }
    public func help<S: StringProtocol>(_ text: S) -> some View { /* private */ }
    public func help(_ text: Text) -> some View { /* private */ }
    public func labelsHidden() -> some View { /* private */ }
    public func buttonStyle<S: PrimitiveButtonStyle>(_ style: S) -> some View { /* private */ }
    public func pickerStyle<S: PickerStyle>(_ style: S) -> some View { /* private */ }
    public func textFieldStyle<S: TextFieldStyle>(_ style: S) -> some View { /* private */ }
    public func formStyle<S: FormStyle>(_ style: S) -> some View { /* private */ }
    public func textSelection<S: TextSelectability>(_ selectability: S) -> some View { /* private */ }
    public func tint(_ tint: Color?) -> some View { /* private */ }
    public func controlSize(_ controlSize: ControlSize) -> some View { /* private */ }
    public func keyboardShortcut(_ key: KeyEquivalent, modifiers: EventModifiers = .command) -> some View { /* private */ }
    public func keyboardShortcut(_ shortcut: KeyboardShortcut) -> some View { /* private */ }
    public func onSubmit(of triggers: SubmitTriggers = .text, _ action: @escaping () -> Void) -> some View { /* private */ }
    public func autocorrectionDisabled(_ disable: Bool = true) -> some View { /* private */ }
    public func task(priority: TaskPriority = .userInitiated, _ action: @escaping @Sendable () async -> Void) -> some View { /* private */ }
    public func refreshable(action: @escaping @Sendable () async -> Void) -> some View { /* private */ }
    public func onAppear(perform action: (() -> Void)? = nil) -> some View { /* private */ }
    public func onDisappear(perform action: (() -> Void)? = nil) -> some View { /* private */ }
    public func onChange<V: Equatable>(of value: V, perform action: @escaping (V) -> Void) -> some View { /* private */ }
    public func sheet<Item: Identifiable, Content: View>(item: Binding<Item?>, onDismiss: (() -> Void)? = nil,
                                                         @ViewBuilder content: @escaping (Item) -> Content) -> some View { /* private */ }
    public func sheet<Content: View>(isPresented: Binding<Bool>, onDismiss: (() -> Void)? = nil,
                                     @ViewBuilder content: @escaping () -> Content) -> some View { /* private */ }
    public func navigationTitle(_ title: Text) -> some View { /* private */ }
    public func navigationTitle(_ titleKey: LocalizedStringKey) -> some View { /* private */ }
    public func navigationTitle<S: StringProtocol>(_ title: S) -> some View { /* private */ }
    public func tabItem<V: View>(@ViewBuilder _ label: () -> V) -> some View { /* private */ }
    public func tag<V: Hashable>(_ tag: V) -> some View { /* private */ }
    public func environmentObject<T: ObservableObject>(_ object: T) -> some View { /* private */ }
    public func id<ID: Hashable>(_ id: ID) -> some View { /* private */ }
    public func aspectRatio(_ aspectRatio: CGFloat? = nil, contentMode: ContentMode) -> some View { /* private */ }
    public func position(x: CGFloat = 0, y: CGFloat = 0) -> some View { /* private */ }
    public func accessibilityLabel<S: StringProtocol>(_ label: S) -> some View { /* private */ }
    #if canImport(UIKit)
    public func keyboardType(_ type: UIKeyboardType) -> some View { /* private */ }
    public func textInputAutocapitalization(_ autocapitalization: TextInputAutocapitalization?) -> some View { /* private */ }
    #endif
}

// MARK: - Colour shortcuts in ShapeStyle position (.foregroundStyle(.red))

extension ShapeStyle where Self == Color {
    public static var red: Color { /* private */ }
    public static var green: Color { /* private */ }
    public static var blue: Color { /* private */ }
    public static var orange: Color { /* private */ }
    public static var white: Color { /* private */ }
    public static var black: Color { /* private */ }
    public static var clear: Color { /* private */ }
    public static var gray: Color { /* private */ }
}

// MARK: - Apps and scenes

public protocol Scene {
    associatedtype Body: Scene
    @SceneBuilder @MainActor var body: Self.Body { get }
}

extension Never: Scene {}

public protocol _PrimitiveScene: Scene where Body == Never {}
extension _PrimitiveScene {
    public var body: Never { /* private */ }
}

public struct _TupleScene: _PrimitiveScene {}
public struct _ModifiedScene: _PrimitiveScene {}

@resultBuilder
public struct SceneBuilder {
    public static func buildBlock<C: Scene>(_ content: C) -> C { /* private */ }
    public static func buildBlock<each C: Scene>(_ content: repeat each C) -> _TupleScene { /* private */ }
    public static func buildExpression<C: Scene>(_ content: C) -> C { /* private */ }
}

public protocol App {
    associatedtype Body: Scene
    @SceneBuilder @MainActor var body: Self.Body { get }
    @MainActor init()
}

extension App {
    @MainActor public static func main() { /* private */ }
}

public struct WindowGroup<Content: View>: _PrimitiveScene {
    public init(@ViewBuilder content: () -> Content) { /* private */ }
    public init(_ title: LocalizedStringKey, id: String, @ViewBuilder content: () -> Content) { /* private */ }
}

public struct Window<Content: View>: _PrimitiveScene {
    public init(_ title: LocalizedStringKey, id: String, @ViewBuilder content: () -> Content) { /* private */ }
    public init<S: StringProtocol>(_ title: S, id: String, @ViewBuilder content: () -> Content) { /* private */ }
}

public struct Settings<Content: View>: _PrimitiveScene {
    public init(@ViewBuilder content: () -> Content) { /* private */ }
}

public struct MenuBarExtra<Label: View, Content: View>: _PrimitiveScene {
    public init(@ViewBuilder content: () -> Content, @ViewBuilder label: () -> Label) { /* private */ }
}

extension Scene {
    public func defaultSize(width: CGFloat, height: CGFloat) -> some Scene { /* private */ }
}

// MARK: - Environment and storage

public struct OpenWindowAction {
    @MainActor public func callAsFunction(id: String) { /* private */ }
}

public struct OpenURLAction {
    @MainActor public func callAsFunction(_ url: URL) { /* private */ }
}

public struct DismissAction {
    @MainActor public func callAsFunction() { /* private */ }
}

public struct EnvironmentValues {
    public var openWindow: OpenWindowAction { /* private */ }
    public var openURL: OpenURLAction { /* private */ }
    public var dismiss: DismissAction { /* private */ }
    public var colorScheme: ColorScheme { /* private */ }
    public var accessibilityReduceMotion: Bool { /* private */ }
}

@propertyWrapper
public struct Environment<Value>: DynamicProperty {
    public init(_ keyPath: KeyPath<EnvironmentValues, Value>) { /* private */ }
    public var wrappedValue: Value { /* private */ }
}

@propertyWrapper
public struct AppStorage<Value>: DynamicProperty {
    private let box: _Box<Value>
    public var wrappedValue: Value {
        get { /* private */ }
        nonmutating set { /* private */ }
    }
    public var projectedValue: Binding<Value> { /* private */ }
}

extension AppStorage where Value == Bool {
    public init(wrappedValue: Value, _ key: String, store: UserDefaults? = nil) { /* private */ }
}

extension AppStorage where Value == String {
    public init(wrappedValue: Value, _ key: String, store: UserDefaults? = nil) { /* private */ }
}

extension AppStorage where Value == Int {
    public init(wrappedValue: Value, _ key: String, store: UserDefaults? = nil) { /* private */ }
}

// MARK: - Toolbars

public protocol ToolbarContent {}

public struct _ToolbarTuple: ToolbarContent {}

@resultBuilder
public struct ToolbarContentBuilder {
    public static func buildBlock<C: ToolbarContent>(_ content: C) -> C { /* private */ }
    public static func buildBlock<each C: ToolbarContent>(_ content: repeat each C) -> _ToolbarTuple { /* private */ }
    public static func buildExpression<C: ToolbarContent>(_ content: C) -> C { /* private */ }
}

public struct ToolbarItemPlacement {
    public static let automatic , primaryAction
    public static let principal , navigation
    public static let confirmationAction , cancellationAction
}

public struct ToolbarItem<ID, Content: View>: ToolbarContent {}

extension ToolbarItem where ID == () {
    public init(placement: ToolbarItemPlacement = .automatic, @ViewBuilder content: () -> Content) { /* private */ }
}

extension View {
    public func toolbar<Content: ToolbarContent>(@ToolbarContentBuilder content: () -> Content) -> some View { /* private */ }
}

#if canImport(AppKit)
import AppKit

extension Color {
    public init(nsColor: NSColor) { /* private */ }
}

@propertyWrapper
public struct NSApplicationDelegateAdaptor<DelegateType: NSObject & NSApplicationDelegate>: DynamicProperty {
    public init(_ delegateType: DelegateType.Type = DelegateType.self) { /* private */ }
    public var wrappedValue: DelegateType { /* private */ }
}

public struct NSViewRepresentableContext<Representable: NSViewRepresentable> {
    public let coordinator: Representable.Coordinator
}

public protocol NSViewRepresentable: View where Body == Never {
    associatedtype NSViewType: NSView
    associatedtype Coordinator = Void
    typealias Context = NSViewRepresentableContext<Self>
    @MainActor func makeNSView(context: Self.Context) -> Self.NSViewType
    @MainActor func updateNSView(_ nsView: Self.NSViewType, context: Self.Context)
    @MainActor func makeCoordinator() -> Self.Coordinator
}

extension NSViewRepresentable {
    public var body: Never { /* private */ }
}

extension NSViewRepresentable where Coordinator == Void {
    public func makeCoordinator() { /* private */ }
}
#endif

#if canImport(UIKit)
public struct UIViewControllerRepresentableContext<Representable: UIViewControllerRepresentable> {
    public let coordinator: Representable.Coordinator
}

public protocol UIViewControllerRepresentable: View where Body == Never {
    associatedtype UIViewControllerType: UIViewController
    associatedtype Coordinator = Void
    typealias Context = UIViewControllerRepresentableContext<Self>
    @MainActor func makeUIViewController(context: Self.Context) -> Self.UIViewControllerType
    @MainActor func updateUIViewController(_ uiViewController: Self.UIViewControllerType, context: Self.Context)
    @MainActor static func dismantleUIViewController(_ uiViewController: Self.UIViewControllerType, coordinator: Self.Coordinator)
    @MainActor func makeCoordinator() -> Self.Coordinator
}

extension UIViewControllerRepresentable {
    public var body: Never { /* private */ }
    public static func dismantleUIViewController(_ uiViewController: Self.UIViewControllerType, coordinator: Self.Coordinator) { /* private */ }
}

extension UIViewControllerRepresentable where Coordinator == Void {
    public func makeCoordinator() { /* private */ }
}
#endif
