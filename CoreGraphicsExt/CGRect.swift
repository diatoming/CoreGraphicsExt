//
//  CGRect.swift
//  Core Graphics Extended Library
//
//  Created by Manfred Lau on 10/18/14.
//
//

import CoreGraphics

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
    
    /// Create a CGRect value with given vertices parameters
    public init(top: CGFloat, right: CGFloat, bottom: CGFloat, left: CGFloat) {
        origin = CGPointMake(left, top)
        size = CGSize(width: right - left, height: bottom - top)
    }
}

extension CGRect {
    /// Create a CGRect value which covers all the given points
    public init(points: CGPoint ...) {
        var mostTop = CGFloat.max ,
        mostBottom = -CGFloat.max,
        mostRight = -CGFloat.max,
        mostLeft = CGFloat.max
        
        for eachPoint in points {
            if (eachPoint.y < mostTop) { mostTop = eachPoint.y }
            if (eachPoint.x > mostRight) { mostRight = eachPoint.x }
            if (eachPoint.y > mostBottom) { mostBottom = eachPoint.y }
            if (eachPoint.x < mostLeft) { mostLeft = eachPoint.x }
        }
        
        origin = CGPointMake(mostLeft, mostTop)
        size = CGSize(width: mostRight - mostLeft, height: mostBottom - mostTop)
    }
    
    /// Create a CGRect value which covers all the given points
    public init(arrayOfPoints: [CGPoint] ...) {
        var mostTop = CGFloat.max ,
        mostBottom = -CGFloat.max,
        mostRight = -CGFloat.max,
        mostLeft = CGFloat.max
        
        for eachPointArray in arrayOfPoints {
            for eachPoint in eachPointArray {
                if (eachPoint.y < mostTop) { mostTop = eachPoint.y }
                if (eachPoint.x > mostRight) { mostRight = eachPoint.x }
                if (eachPoint.y > mostBottom) { mostBottom = eachPoint.y }
                if (eachPoint.x < mostLeft) { mostLeft = eachPoint.x }
            }
        }
        
        origin = CGPointMake(mostLeft, mostTop)
        size = CGSize(width: mostRight - mostLeft, height: mostBottom - mostTop)
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

public enum CGCoordinateSystemAxis: Int {
    case Horizontal
    case Vertical
}

extension CGRect {
    public enum AlginmentAnchor: Int {
        case Min, Mid, Max
    }
    
    public mutating func alignAnchor(anchor: AlginmentAnchor,
        onAxis axis: CGCoordinateSystemAxis,
        withAnchor referenceRectAnchor: AlginmentAnchor,
        ofRectInPlace referenceRect: CGRect)
    {
        self = alignAnchor(anchor,
            onAxis: axis,
            withAnchor: referenceRectAnchor,
            ofRect: referenceRect)
    }
    
    public func alignAnchor(anchor: AlginmentAnchor,
        onAxis axis: CGCoordinateSystemAxis,
        withAnchor referenceRectAnchor: AlginmentAnchor,
        ofRect referenceRect: CGRect)
         -> CGRect
    {
        switch axis {
        case .Vertical:
            switch (anchor, referenceRectAnchor) {
            case (.Min, .Min):
                return CGRect(origin: CGPoint(x: referenceRect.minX, y: minY),
                    size: size)
            case (.Min, .Mid):
                return CGRect(origin: CGPoint(x: referenceRect.midX, y: minY),
                    size: size)
            case (.Min, .Max):
                return CGRect(origin: CGPoint(x: referenceRect.maxX, y: minY),
                    size: size)
                
            case (.Max, .Max):
                let origin = CGPoint(x: referenceRect.maxX - size.width,
                    y: minY)
                return CGRect(origin: origin, size: size)
            case (.Max, .Mid):
                let origin = CGPoint(x: referenceRect.midX - size.width,
                    y: minY)
                return CGRect(origin: origin, size: size)
            case (.Max, .Min):
                let origin = CGPoint(x: referenceRect.minX - size.width,
                    y: minY)
                return CGRect(origin: origin, size: size)
                
            case (.Mid, .Min):
                return CGRect(center: CGPoint(x: referenceRect.minX, y: minY),
                    size: size)
            case (.Mid, .Mid):
                return CGRect(center: CGPoint(x: referenceRect.midX, y: minY),
                    size: size)
            case (.Mid, .Max):
                return CGRect(center: CGPoint(x: referenceRect.maxX, y: minY),
                    size: size)
            }
        case .Horizontal:
            switch (anchor, referenceRectAnchor) {
            case (.Min, .Min):
                return CGRect(origin: CGPoint(x: minX, y: referenceRect.minY),
                    size: size)
            case (.Min, .Mid):
                return CGRect(origin: CGPoint(x: minX, y: referenceRect.midY),
                    size: size)
            case (.Min, .Max):
                return CGRect(origin: CGPoint(x: minX, y: referenceRect.maxY),
                    size: size)
                
            case (.Max, .Max):
                let origin = CGPoint(x: minX,
                    y: referenceRect.maxY - size.height)
                return CGRect(origin: origin, size: size)
            case (.Max, .Mid):
                let origin = CGPoint(x: minX,
                    y: referenceRect.midX - size.height)
                return CGRect(origin: origin, size: size)
            case (.Max, .Min):
                let origin = CGPoint(x: minX,
                    y: referenceRect.minY - size.height)
                return CGRect(origin: origin, size: size)
                
            case (.Mid, .Min):
                return CGRect(center: CGPoint(x: minX, y: referenceRect.minY),
                    size: size)
            case (.Mid, .Mid):
                return CGRect(center: CGPoint(x: minX, y: referenceRect.midY),
                    size: size)
            case (.Mid, .Max):
                return CGRect(center: CGPoint(x: minX, y: referenceRect.maxY),
                    size: size)
            }
        }
    }
}
