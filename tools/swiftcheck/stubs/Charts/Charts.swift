// Source code is private. This file shows only its types and signatures.

@_exported import SwiftUI

public protocol ChartContent {
    associatedtype Body: ChartContent
    @ChartContentBuilder var body: Self.Body { get }
}

extension Never: ChartContent {}

public protocol _PrimitiveMark: ChartContent where Body == Never {}
extension _PrimitiveMark {
    public var body: Never { /* private */ }
}

public struct EmptyChartContent: _PrimitiveMark { public init() { /* private */ }}
public struct TupleChartContent<T>: _PrimitiveMark {
    public init(_ value: T) { /* private */ }
}
public struct _ConditionalChartContent<T: ChartContent, F: ChartContent>: _PrimitiveMark {}
public struct _OptionalChartContent<C: ChartContent>: _PrimitiveMark {}

@resultBuilder
public struct ChartContentBuilder {
    public static func buildBlock() -> EmptyChartContent { /* private */ }
    public static func buildBlock<C: ChartContent>(_ content: C) -> C { /* private */ }
    public static func buildBlock<each C: ChartContent>(_ content: repeat each C) -> TupleChartContent<(repeat each C)> { /* private */ }
    public static func buildExpression<C: ChartContent>(_ content: C) -> C { /* private */ }
    public static func buildIf<C: ChartContent>(_ content: C?) -> _OptionalChartContent<C> { /* private */ }
    public static func buildEither<T: ChartContent, F: ChartContent>(first: T) -> _ConditionalChartContent<T, F> { /* private */ }
    public static func buildEither<T: ChartContent, F: ChartContent>(second: F) -> _ConditionalChartContent<T, F> { /* private */ }
}

public protocol Plottable {}
extension Date: Plottable {}
extension Double: Plottable {}
extension Float: Plottable {}
extension Int: Plottable {}
extension String: Plottable {}
extension CGFloat: Plottable {}

public struct PlottableValue<Value: Plottable> {
    public static func value(_ label: LocalizedStringKey, _ value: Value) -> PlottableValue<Value> { /* private */ }
    public static func value<S: StringProtocol>(_ label: S, _ value: Value) -> PlottableValue<Value> { /* private */ }
}

public struct MarkDimension: ExpressibleByFloatLiteral, ExpressibleByIntegerLiteral {
    public init(floatLiteral value: Double) { /* private */ }
    public init(integerLiteral value: Int) { /* private */ }
    init() { /* private */ }
    public static var automatic: MarkDimension { /* private */ }
    public static func fixed(_ value: CGFloat) -> MarkDimension { /* private */ }
    public static func ratio(_ value: CGFloat) -> MarkDimension { /* private */ }
    public static func inset(_ value: CGFloat) -> MarkDimension { /* private */ }
}

public struct AnnotationPosition {
    public static let automatic , top , bottom
    public static let leading , trailing , overlay
    public static let topLeading , topTrailing
    public static let bottomLeading , bottomTrailing
}

public protocol ChartSymbolShape {}
public struct BasicChartSymbolShape: ChartSymbolShape {}
extension ChartSymbolShape where Self == BasicChartSymbolShape {
    public static var circle: BasicChartSymbolShape { /* private */ }
    public static var square: BasicChartSymbolShape { /* private */ }
    public static var triangle: BasicChartSymbolShape { /* private */ }
    public static var diamond: BasicChartSymbolShape { /* private */ }
    public static var pentagon: BasicChartSymbolShape { /* private */ }
    public static var plus: BasicChartSymbolShape { /* private */ }
    public static var cross: BasicChartSymbolShape { /* private */ }
    public static var asterisk: BasicChartSymbolShape { /* private */ }
}

public struct RuleMark: _PrimitiveMark {
    public init<X: Plottable>(x: PlottableValue<X>) { /* private */ }
    public init<Y: Plottable>(y: PlottableValue<Y>) { /* private */ }
    public init<X: Plottable, Y: Plottable>(x: PlottableValue<X>, yStart: PlottableValue<Y>, yEnd: PlottableValue<Y>) { /* private */ }
    public init<X: Plottable, Y: Plottable>(xStart: PlottableValue<X>, xEnd: PlottableValue<X>, y: PlottableValue<Y>) { /* private */ }
}

public struct RectangleMark: _PrimitiveMark {
    public init<X: Plottable, Y: Plottable>(x: PlottableValue<X>, y: PlottableValue<Y>, width: MarkDimension = .automatic,
                                            height: MarkDimension = .automatic) { /* private */ }
    public init<X: Plottable, Y: Plottable>(xStart: PlottableValue<X>, xEnd: PlottableValue<X>, y: PlottableValue<Y>,
                                            height: MarkDimension = .automatic) { /* private */ }
    public init<X: Plottable, Y: Plottable>(x: PlottableValue<X>, yStart: PlottableValue<Y>, yEnd: PlottableValue<Y>,
                                            width: MarkDimension = .automatic) { /* private */ }
    public init<X: Plottable, Y: Plottable>(xStart: PlottableValue<X>, xEnd: PlottableValue<X>, yStart: PlottableValue<Y>,
                                            yEnd: PlottableValue<Y>) { /* private */ }
}

public struct PointMark: _PrimitiveMark {
    public init<X: Plottable, Y: Plottable>(x: PlottableValue<X>, y: PlottableValue<Y>) { /* private */ }
}

public struct BarMark: _PrimitiveMark {
    public init<X: Plottable, Y: Plottable>(x: PlottableValue<X>, y: PlottableValue<Y>, width: MarkDimension = .automatic,
                                            height: MarkDimension = .automatic) { /* private */ }
}

public struct LineMark: _PrimitiveMark {
    public init<X: Plottable, Y: Plottable>(x: PlottableValue<X>, y: PlottableValue<Y>) { /* private */ }
}

public struct _ModifiedMark<M: ChartContent>: _PrimitiveMark {}

extension ChartContent {
    public func foregroundStyle<S: ShapeStyle>(_ style: S) -> some ChartContent { /* private */ }
    public func lineStyle(_ style: StrokeStyle) -> some ChartContent { /* private */ }
    public func opacity(_ value: Double) -> some ChartContent { /* private */ }
    public func symbol<S: ChartSymbolShape>(_ symbol: S) -> some ChartContent { /* private */ }
    public func symbolSize(_ area: CGFloat) -> some ChartContent { /* private */ }
    public func annotation<C: View>(position: AnnotationPosition = .automatic, alignment: Alignment = .center,
                                    spacing: CGFloat? = nil, @ViewBuilder content: () -> C) -> some ChartContent { /* private */ }
}

extension ForEach: ChartContent where Content: ChartContent {
    public var body: Never { /* private */ }
    public init(_ data: Data, @ChartContentBuilder content: @escaping (Data.Element) -> Content)
        where ID == Data.Element.ID, Data.Element: Identifiable { /* private */ }
    public init(_ data: Data, id: KeyPath<Data.Element, ID>, @ChartContentBuilder content: @escaping (Data.Element) -> Content) { /* private */ }
}

public struct Chart<Content: ChartContent>: View {
    public init(@ChartContentBuilder content: () -> Content) { /* private */ }
    public var body: Never { /* private */ }
}

// MARK: - Axes and scales

public protocol AxisContent {}
public protocol AxisMark: AxisContent {}

@resultBuilder
public struct AxisContentBuilder {
    public static func buildBlock<C: AxisContent>(_ content: C) -> C { /* private */ }
    public static func buildBlock<each C: AxisContent>(_ content: repeat each C) -> _AxisTuple { /* private */ }
    public static func buildExpression<C: AxisContent>(_ content: C) -> C { /* private */ }
}

@resultBuilder
public struct AxisMarkBuilder {
    public static func buildBlock<C: AxisMark>(_ content: C) -> C { /* private */ }
    public static func buildBlock<each C: AxisMark>(_ content: repeat each C) -> _AxisTuple { /* private */ }
    public static func buildExpression<C: AxisMark>(_ content: C) -> C { /* private */ }
    public static func buildIf<C: AxisMark>(_ content: C?) -> _AxisTuple { /* private */ }
}

public struct _AxisTuple: AxisMark {}

public struct AxisValue {
    public var index: Int { /* private */ }
    public var count: Int { /* private */ }
    public func `as`<P: Plottable>(_ type: P.Type) -> P? { /* private */ }
}

public struct AxisMarkPosition {
    public static let automatic , leading , trailing
    public static let top , bottom
}

public struct AxisMarkPreset {
    public static let automatic , aligned , extended , inset
}

public struct AxisMarks<Content: AxisContent>: AxisContent {
    public init<Values: Plottable>(preset: AxisMarkPreset = .automatic, position: AxisMarkPosition = .automatic,
                                   values: [Values], @AxisMarkBuilder content: @escaping (AxisValue) -> Content) { /* private */ }
}

extension AxisMarks where Content == _AxisTuple {
    public init(preset: AxisMarkPreset = .automatic, position: AxisMarkPosition = .automatic) { /* private */ }
}

public struct AxisGridLine: AxisMark {
    public init(centered: Bool? = nil, stroke: StrokeStyle? = nil) { /* private */ }
}

public struct AxisTick: AxisMark {
    public init(centered: Bool? = nil, length: CGFloat? = nil, stroke: StrokeStyle? = nil) { /* private */ }
}

public struct AxisValueLabel: AxisMark {
    public init<Content: View>(centered: Bool? = nil, anchor: UnitPoint? = nil, multiLabelAlignment: Alignment? = nil,
                               offsetsMarks: Bool? = nil, horizontalSpacing: CGFloat? = nil, verticalSpacing: CGFloat? = nil,
                               @ViewBuilder content: () -> Content) { /* private */ }
}

public struct _ModifiedAxisMark: AxisMark {}

extension AxisMark {
    public func foregroundStyle<S: ShapeStyle>(_ style: S) -> some AxisMark { /* private */ }
}

public protocol ScaleDomain {}
extension ClosedRange: ScaleDomain where Bound: Plottable {}
extension Range: ScaleDomain where Bound: Plottable {}
extension Array: ScaleDomain where Element: Plottable {}

extension View {
    public func chartXScale<Domain: ScaleDomain>(domain: Domain) -> some View { /* private */ }
    public func chartYScale<Domain: ScaleDomain>(domain: Domain) -> some View { /* private */ }
    public func chartXAxis<C: AxisContent>(@AxisContentBuilder content: () -> C) -> some View { /* private */ }
    public func chartYAxis<C: AxisContent>(@AxisContentBuilder content: () -> C) -> some View { /* private */ }
    public func chartXAxis(_ visibility: Visibility) -> some View { /* private */ }
    public func chartYAxis(_ visibility: Visibility) -> some View { /* private */ }
}
