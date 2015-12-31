//
//  CGRect.swift
//  Core Graphics Extended Library
//
//  Created by Manfred Lau on 10/18/14.
//
//

import CoreGraphics

extension CGRect: CustomStringConvertible {
    public var description: String {
        return "<\(self.dynamicType): X = \(self.origin.x), Y = \(self.origin.y), Width = \(self.width), Height = \(self.height)>"
    }
}

extension CGRect: Hashable {
    public var hashValue: Int {
        return "<\(self.dynamicType): X = \(self.origin.x), Y = \(self.origin.y), Width = \(self.width), Height = \(self.height)>".hashValue
    }
}

/// Vertices on CGRect
public enum CGRectVertex: Int,
    CustomDebugStringConvertible,
    CustomStringConvertible
{
    case TopRight    = 0
    case BottomRight = 1
    case BottomLeft  = 2
    case TopLeft     = 3
    
    public var description: String {
        switch self {
        case .TopRight:     return "Top Right"
        case .BottomRight:  return "Bottom Right"
        case .BottomLeft:   return "Bottom Left"
        case .TopLeft:      return "Top Left"
        }
    }
    
    public var debugDescription: String {
        return description
    }
    
    private class CGRectVertexGenerator : GeneratorType {
        var rawValue = 0
        typealias Element = CGRectVertex
        func next() -> Element? {
            let element = CGRectVertex(rawValue: rawValue)
            rawValue += 1
            return element
        }
    }
    
    public static func enumerate() -> AnySequence<CGRectVertex> {
        return AnySequence({ CGRectVertexGenerator() })
    }
}

extension CGRect {
    // Get the center of a CGRect value
    public var center: CGPoint {
        get {
            return CGPoint(x: origin.x + size.width * 0.5,
                y: origin.y + size.height * 0.5)
        }
        set {
            origin = CGPoint(x: newValue.x - size.width * 0.5,
                y: newValue.y - size.height * 0.5)
        }
    }
}

private class CGRectGenerator : GeneratorType {
    let rect: CGRect
    var rawValue = 0
    typealias Element = CGPoint
    
    init(_ aRect: CGRect) {
        rect = aRect
    }
    
    func next() -> Element? {
        if let vertex = CGRectVertex(rawValue: rawValue) {
            let element = rect.vertex(vertex)
            rawValue += 1
            return element
        } else {
            return nil
        }
    }
}

extension CGRect {
    /// Get the specific vertex on the rectangle
    public func vertex(vertex: CGRectVertex) -> CGPoint {
        switch vertex {
        case .TopRight:
            return CGPoint(x: maxX, y: minY);
        case .BottomRight:
            return CGPoint(x: maxX, y: maxY);
        case .BottomLeft:
            return CGPoint(x: minX, y: maxY);
        case .TopLeft:
            return CGPoint(x: minX, y: minY);
        }
    }
    
    public typealias CGRectVertices = (topRight: CGPoint,
        bottomRight: CGPoint,
        bottomLeft: CGPoint,
        topLeft: CGPoint)
    // Get all the vertices on the rectangle
    public var vertices: CGRectVertices {
        return (self.vertex(.TopRight),
            self.vertex(.BottomRight),
            self.vertex(.BottomLeft),
            self.vertex(.TopLeft))
    }
    
    public func enumerate() -> AnySequence<CGPoint> {
        return AnySequence({CGRectGenerator(self)})
    }
}

extension CGRect {
    /// Create a CGRect value with the given size and (0,0) origin.
    public init(size aSize: CGSize) {
        origin = CGPoint.zero
        size = aSize
    }
    
    /// Create a CGRect value with the given center and size
    public init(center: CGPoint, size aSize: CGSize) {
        origin = CGPoint(x: center.x - aSize.width * 0.5,
            y: center.y - aSize.height * 0.5)
        size = aSize
    }
    
    /// Create a CGRect value with the given center, width and height
    public init(center: CGPoint, width: CGFloat, height: CGFloat) {
        let aSize = CGSize(width: width, height: height)
        origin = CGPoint(x: center.x - aSize.width * 0.5,
            y: center.y - aSize.height * 0.5)
        size = aSize
    }
    
    /// Create a CGRect value with the given CGRect which replace its origin or
    /// size if necessary
    public init(rect: CGRect,
        origin anOrigin: CGPoint? = nil,
        size aSize: CGSize? = nil)
    {
        if let theOrigin = anOrigin {
            origin = theOrigin
        } else {
            origin = rect.origin
        }
        if let theSize = aSize {
            size = theSize
        } else {
            size = rect.size
        }
    }
}

extension CGRect {
    /// Create a CGRect value which covers all the given points
    public init(points: CGPoint ...) {
        var minY = CGFloat.max ,
        maxY = -CGFloat.max,
        maxX = -CGFloat.max,
        minX = CGFloat.max
        
        for eachPoint in points {
            if (eachPoint.y < minY) { minY = eachPoint.y }
            if (eachPoint.x > maxX) { maxX = eachPoint.x }
            if (eachPoint.y > maxY) { maxY = eachPoint.y }
            if (eachPoint.x < minX) { minX = eachPoint.x }
        }
        
        origin = CGPointMake(minX, minY)
        size = CGSize(width: maxX - minX, height: maxY - minY)
    }
    
    /// Create a CGRect value which covers all the given points
    public init(arrayOfPoints: [CGPoint] ...) {
        var minY = CGFloat.max ,
        maxY = -CGFloat.max,
        maxX = -CGFloat.max,
        minX = CGFloat.max
        
        for eachPointArray in arrayOfPoints {
            for eachPoint in eachPointArray {
                if (eachPoint.y < minY) { minY = eachPoint.y }
                if (eachPoint.x > maxX) { maxX = eachPoint.x }
                if (eachPoint.y > maxY) { maxY = eachPoint.y }
                if (eachPoint.x < minX) { minX = eachPoint.x }
            }
        }
        
        origin = CGPointMake(minX, minY)
        size = CGSize(width: maxX - minX, height: maxY - minY)
    }
    
    /// Create a CGRect value which covers all the given rects
    public init(rects: CGRect...) {
        var points = [CGPoint]()
        for rect in rects {
            for point in rect.enumerate() {
                points.append(point)
            }
        }
        self = CGRect(arrayOfPoints: points)
    }
    
    /// Create a CGRect value which covers all the given rects
    public init(arrayOfRect: [CGRect]) {
        var points = [CGPoint]()
        for rect in arrayOfRect {
            for point in rect.enumerate() {
                points.append(point)
            }
        }
        self = CGRect(arrayOfPoints: points)
    }
}

extension CGRect {
    /// Return a CGRect value whose origin replaced by the given origin
    public func replaceOrigin(origin: CGPoint) -> CGRect {
        return CGRect(origin: origin, size: size)
    }
    
    /// Replace rect's origin
    public mutating func replaceOriginInPlace(origin: CGPoint) {
        self.origin = origin
    }
    
    /// Return a CGRect value whose origin's x and y replaced by the given
    /// x and y
    public func replaceOrigin(x x: CGFloat? = nil, y: CGFloat? = nil)
        -> CGRect
    {
        let newOrigin = CGPoint(x: x == nil ? origin.x: x!,
            y: y == nil ? origin.y: y!)
        return CGRect(origin: newOrigin, size: size)
    }
    
    /// Replace rect's origin
    public mutating func replaceOriginInPlace(x x: CGFloat? = nil,
        y: CGFloat? = nil)
    {
        let newOrigin = CGPoint(x: x == nil ? origin.x: x!,
            y: y == nil ? origin.y: y!)
        self.origin = newOrigin
    }
}


extension CGRect {
    /// Return a CGRect value whose size replaced by the given size
    public func replaceSize(size: CGSize) -> CGRect {
        return CGRect(origin: origin, size: size)
    }
    
    /// Replace rect's size
    public mutating func replaceSizeInPlace(size: CGSize) {
        self.size = size
    }
    
    /// Return a CGRect value whose size's width and height replaced by the
    /// given width and height
    public func replaceSize(width width: CGFloat? = nil, height: CGFloat? = nil)
        -> CGRect
    {
        let newSize = CGSize(width: width == nil ? size.width: width!,
            height: height == nil ? size.height: height!)
        return CGRect(origin: origin, size: newSize)
    }
    
    /// Replace rect's size
    public mutating func replaceSizeInPlace(width width: CGFloat? = nil,
        height: CGFloat? = nil)
    {
        let newSize = CGSize(width: width == nil ? size.width: width!,
            height: height == nil ? size.height: height!)
        self.size = newSize
    }
}

extension CGRect {
    /// Return a CGRect value whose width and height has been swapped
    public func swapDimension() -> CGRect {
        return CGRectMake(origin.x, origin.y, size.height, size.width);
    }
    
    /// Swap rect's width and height
    public mutating func swapDimensionInPlace() {
        self.size = self.size.swapDimension()
    }
}

extension CGRect {
    /// Mix with an other CGRect
    /// Linear mix the CGFloat value with the given value and percentage
    public func mix(mixedValue: CGRect, percentage: CGFloat) -> CGRect {
        return CGRect(x: (self.origin.x * (1 - percentage) +
            mixedValue.origin.x * percentage),
            y: (self.origin.y * (1 - percentage) +
                mixedValue.origin.y * percentage),
            width: (self.size.width * (1 - percentage) +
                mixedValue.size.width * percentage),
            height: (self.size.height * (1 - percentage) +
                mixedValue.size.height * percentage))
    }
}

extension CGRect {
    public func offsetBy(offset: CGPoint) -> CGRect {
        return offsetBy(dx: offset.x, dy: offset.y)
    }
    
    public mutating func offsetInPlace(offset: CGPoint) {
        offsetInPlace(dx: offset.x, dy: offset.y)
    }
}

extension CGRect {
    /// Check if the rectangle touches the given rectangle
    public func touches(rect: CGRect) -> Bool {
        return !((maxX < rect.minX || minX > rect.maxX) ||
            (maxY < rect.minY || minY > rect.maxY))
    }
}

public protocol CGRectAnchorType {
    func ofRect(alignedRect: CGRect,
        alignTo side: Self,
        ofRect aligningRect: CGRect)
        -> CGRect
}

extension CGRect {
    public mutating func alignInPlace<A: CGRectAnchorType>(
        side: A,
        toSide: A,
        ofRect aligningRect: CGRect)
    {
        self = side.ofRect(self, alignTo: toSide, ofRect: aligningRect)
    }
    
    public func align<A: CGRectAnchorType>(side: A,
        toSide: A,
        ofRect aligningRect: CGRect)
        -> CGRect
    {
        return side.ofRect(self, alignTo: toSide, ofRect: aligningRect)
    }
}

public enum CGRectVerticalAnchor: Int, CGRectAnchorType {
    case Top, Mid, Bottom
}

public enum CGRectHorizontalAnchor: Int, CGRectAnchorType {
    case Left, Mid, Right
}

public func + (lhs: CGRect, rhs: CGRect) -> CGRect {
    return CGRect(x: lhs.origin.x + rhs.origin.x,
        y: lhs.origin.y + rhs.origin.y,
        width: lhs.width + rhs.width,
        height: lhs.height + rhs.height)
}

public func += (inout lhs: CGRect, rhs: CGRect) {
    lhs = CGRect(x: lhs.origin.x + rhs.origin.x,
        y: lhs.origin.y + rhs.origin.y,
        width: lhs.width + rhs.width,
        height: lhs.height + rhs.height)
}

public func - (lhs: CGRect, rhs: CGRect) -> CGRect {
    return CGRect(x: lhs.origin.x - rhs.origin.x,
        y: lhs.origin.y - rhs.origin.y,
        width: lhs.width - rhs.width,
        height: lhs.height - rhs.height)
}

public func -= (inout lhs: CGRect, rhs: CGRect) {
    lhs = CGRect(x: lhs.origin.x - rhs.origin.x,
        y: lhs.origin.y - rhs.origin.y,
        width: lhs.width - rhs.width,
        height: lhs.height - rhs.height)
}

