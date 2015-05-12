//
//  CGRect.swift
//  Core Graphics Extended Library
//
//  Created by Manfred Lau on 10/18/14.
//
//

import CoreGraphics

/// Vertices on CGRect
public enum CGRectVertex: Int, DebugPrintable, Printable {
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
        default:            return String(rawValue)
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
    
    public static func enumerate() -> SequenceOf<CGRectVertex> {
        return SequenceOf<CGRectVertex>({ CGRectVertexGenerator() })
    }
}

extension CGRect {
    // Get the center of a CGRect value
    public var center: CGPoint {
        get {return CGPoint(x: origin.x + size.width * 0.5, y: origin.y + size.height * 0.5)}
        set {origin = CGPoint(x: newValue.x - size.width * 0.5, y: newValue.y - size.height * 0.5)}
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
    
    // Get all the vertices on the rectangle
    public var vertices: (topRight: CGPoint, bottomRight: CGPoint, bottomLeft: CGPoint, topLeft: CGPoint) {
        return (self.vertex(.TopRight), self.vertex(.BottomRight), self.vertex(.BottomLeft), self.vertex(.TopLeft))
    }
    
    public func enumerate() -> SequenceOf<CGPoint> {
        return SequenceOf<CGPoint>({CGRectGenerator(self)})
    }
}

extension CGRect {
    /// Create a CGRect value with a given center and size
    public init(center: CGPoint, size aSize: CGSize) {
        origin = CGPoint(x: center.x - aSize.width * 0.5, y: center.y - aSize.height * 0.5)
        size = aSize
    }
    
    /// Create a CGRect value with a given center, width and height
    public init(center: CGPoint, width: CGFloat, height: CGFloat) {
        let aSize = CGSize(width: width, height: height)
        origin = CGPoint(x: center.x - aSize.width * 0.5, y: center.y - aSize.height * 0.5)
        size = aSize
    }
    
    /// Create a CGRect value with a given CGRect value which replace its origin or size if necessary
    public init(rect: CGRect, origin anOrigin: CGPoint?, size aSize: CGSize?) {
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
    
    /// Create a CGRect value which covers all the given points
    public init(points: CGPoint ...) {
        var mostTop = CGFloat.max , mostBottom = -CGFloat.max, mostRight = -CGFloat.max, mostLeft = CGFloat.max
        
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
        var mostTop = CGFloat.max , mostBottom = -CGFloat.max, mostRight = -CGFloat.max, mostLeft = CGFloat.max
        
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
    
    /// Create a CGRect value which offsets the given CGRect
    public init(rect: CGRect, offset anOffset: CGPoint) {
        self = rect
        offset(dx: anOffset.x, dy: anOffset.y)
    }
    
    /// Create a CGRect value which offsets the given CGRect
    public init(rect: CGRect, dx: CGFloat, dy: CGFloat) {
        self = rect
        offset(dx: dx, dy: dy)
    }
    
    /// Create a CGRect value with given vertices parameters
    public init(top: CGFloat, right: CGFloat, bottom: CGFloat, left: CGFloat) {
        origin = CGPointMake(left, top)
        size = CGSize(width: right - left, height: bottom - top)
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
    
    /// Return a CGRect value whose origin's x value replaced by the given value
    public func rectWithOriginX(originX: CGFloat) -> CGRect {
        return CGRect(origin: CGPoint(x: originX, y: origin.y), size: size)
    }
    
    
    /// Return a CGRect value whose origin's y value replaced by the given value
    public func rectWithOriginY(originY: CGFloat) -> CGRect {
        return CGRect(origin: CGPoint(x: origin.x, y: originY), size: size)
    }
    
    /// Return a CGRect value whose width value replaced by the given value
    public func rectWithWidth(width aWidth: CGFloat) -> CGRect {
        return CGRect(origin: origin, size: CGSize(width: aWidth, height: size.height))
    }
    
    /// Return a CGRect value whose height value replaced by the given value
    public func rectWithHeight(height aHeight: CGFloat) -> CGRect {
        return CGRect(origin: origin, size: CGSize(width: size.width, height: aHeight))
    }
    
    /// Return a CGRect value whose width and height has been swapped
    public func rectWithSwappedDimension() -> CGRect {
        return CGRectMake(origin.x, origin.y, size.height, size.width);
    }
    
    /// Return a CGRect value with the given size. The origin is zero.
    public init(size: CGSize) {
        origin = CGPoint.zeroPoint
        self.size = size
    }
}

extension CGRect {
    /// Return a CGRect value with given offset
    public func rectByOffsetting(point: CGPoint) -> CGRect {
        return self.rectByOffsetting(dx: point.x, dy: point.y)
    }
    
    /// Integral
    public var integeral: CGRect {
        return CGRect(x: ceil(origin.x), y:ceil(origin.y), width: ceil(width), height: ceil(height))
    }
    
    /// Mix with an other CGRect
    /// Linear mix the CGFloat value with the given value and percentage
    public func mix(mixedValue: CGRect, percentage: CGFloat) -> CGRect {
        return CGRect(x: (self.origin.x * (1 - percentage) + mixedValue.origin.x * percentage),
            y: (self.origin.y * (1 - percentage) + mixedValue.origin.y * percentage),
            width: (self.size.width * (1 - percentage) + mixedValue.size.width * percentage),
            height: (self.size.height * (1 - percentage) + mixedValue.size.height * percentage))
    }
}

extension CGRect {
    /// Check if the rectangle touches the given rectangle
    public func touches(rect: CGRect) -> Bool {
        return !((maxX < rect.minX || minX > rect.maxX) || (maxY < rect.minY || minY > rect.maxY))
    }
}
