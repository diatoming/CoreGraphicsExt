//
//  CGRect.swift
//  Core Graphics Extended Library
//
//  Created by Manfred Lau on 10/18/14.
//
//

import CoreGraphics

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
    
    class CGRectVertexGenerator : GeneratorType {
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
    
    public var vertices: (topRight: CGPoint, bottomRight: CGPoint, bottomLeft: CGPoint, topLeft: CGPoint) {
        return (self.vertex(.TopRight), self.vertex(.BottomRight), self.vertex(.BottomLeft), self.vertex(.TopLeft))
    }
    
    public func enumerate() -> SequenceOf<CGPoint> {
        return SequenceOf<CGPoint>({CGRectGenerator(self)})
    }
}

extension CGRect {
    public init(center: CGPoint, size aSize: CGSize) {
        origin = CGPoint(x: center.x - aSize.width * 0.5, y: center.y - aSize.height * 0.5)
        size = aSize
    }
    
    public init(center: CGPoint, width: CGFloat, height: CGFloat) {
        let aSize = CGSize(width: width, height: height)
        origin = CGPoint(x: center.x - aSize.width * 0.5, y: center.y - aSize.height * 0.5)
        size = aSize
    }
    
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
    
    public init(rect: CGRect, offset anOffset: CGPoint) {
        self = rect
        offset(dx: anOffset.x, dy: anOffset.y)
    }
    
    public init(rect: CGRect, dx: CGFloat, dy: CGFloat) {
        self = rect
        offset(dx: dx, dy: dy)
    }
    
    public init(top: CGFloat, right: CGFloat, bottom: CGFloat, left: CGFloat) {
        origin = CGPointMake(left, top)
        size = CGSize(width: right - left, height: bottom - top)
    }
    
    public init(rects: CGRect...) {
        var points = [CGPoint]()
        for rect in rects {
            for point in rect.enumerate() {
                points.append(point)
            }
        }
        self = CGRect(arrayOfPoints: points)
    }
    
    public init(arrayOfRect: [CGRect]) {
        var points = [CGPoint]()
        for rect in arrayOfRect {
            for point in rect.enumerate() {
                points.append(point)
            }
        }
        self = CGRect(arrayOfPoints: points)
    }
    
    public func rectWithOriginX(originX: CGFloat) -> CGRect {
        return CGRect(origin: CGPoint(x: originX, y: origin.y), size: size)
    }
    
    public func rectWithOriginY(originY: CGFloat) -> CGRect {
        return CGRect(origin: CGPoint(x: origin.x, y: originY), size: size)
    }
    
    public func rectWithWidth(width aWidth: CGFloat) -> CGRect {
        return CGRect(origin: origin, size: CGSize(width: aWidth, height: size.height))
    }
    
    public func rectWithHeight(height aHeight: CGFloat) -> CGRect {
        return CGRect(origin: origin, size: CGSize(width: size.width, height: aHeight))
    }
    
    public func rectWithSwappedDimension() -> CGRect {
        return CGRectMake(origin.x, origin.y, size.height, size.width);
    }
    
    public init(size: CGSize) {
        origin = CGPoint.zeroPoint
        self.size = size
    }
}

extension CGRect {
    public func rectByOffsetting(point: CGPoint) -> CGRect {
        return self.rectByOffsetting(dx: point.x, dy: point.y)
    }
    public var integeral: CGSize {
        return CGSize(width: ceil(width), height: ceil(height))
    }
}

extension CGRect {
    public func touches(rect: CGRect) -> Bool {
        return !((maxX < rect.minX || minX > rect.maxX) || (maxY < rect.minY || minY > rect.maxY))
    }
}
