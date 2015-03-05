//
//  CGPoint.swift
//  Core Graphics Extended Library
//
//  Created by Manfred Lau on 10/18/14.
//
//

import CoreGraphics

extension CGPoint {
    public static var zero: CGPoint {
        return CGPoint.zeroPoint
    }
}

extension CGPoint {
    public func offset(offset: CGPoint) -> CGPoint {
        var offsetPoint = self
        offsetPoint.x += offset.x
        offsetPoint.y += offset.y
        return offsetPoint
    }
    
    public func distanceTo(point : CGPoint) -> CGFloat {
        let x1 = x, x2 = point.x
        let y1 = y, y2 = point.y
        let xSquare = pow(x2 - x1, 2.0)
        let ySquare = pow(y2 - y1, 2.0)
        let delta = pow(xSquare + ySquare, 0.5)
        return delta
    }
    
    public func insideCircleOfRect(rect: CGRect) -> Bool {
        return pow(x - rect.origin.x, 2) + pow(y - rect.origin.y, 2) < pow(rect.size.width, 2)
    }
    
    public func onCircleOfRect(rect: CGRect) -> Bool {
        return pow(x - rect.origin.x, 2) + pow(y - rect.origin.y, 2) == pow(rect.size.width, 2)
    }
    
    public func containedByCircleOfRect(rect: CGRect) -> Bool {
        return pow(x - rect.origin.x, 2) + pow(y - rect.origin.y, 2) <= pow(rect.size.width, 2)
    }
    
    public func insideRect(rect: CGRect) -> Bool {
        let pointX = x, pointY = y
        let leftBounds = rect.origin.x
        let rightBounds = rect.origin.x + rect.size.width
        let topBounds = rect.origin.y
        let bottomBounds = rect.origin.y + rect.size.height
        
        if ((pointX < rightBounds && pointX > leftBounds) &&
            (pointY < bottomBounds && pointY > topBounds)) {
                return true
        }
        return false
    }
    
    public func onRect(rect: CGRect) -> Bool {
        let pointX = x, pointY = y
        let leftBounds = rect.origin.x
        let rightBounds = rect.origin.x + rect.size.width
        let topBounds = rect.origin.y
        let bottomBounds = rect.origin.y + rect.size.height
        
        if ((pointX == rightBounds && pointX == leftBounds) &&
            (pointY == bottomBounds && pointY == topBounds)) {
                return true
        }
        return false
    }
    
    public func containedByRect(rect: CGRect) -> Bool {
        let pointX = x, pointY = y
        let leftBounds = rect.origin.x
        let rightBounds = rect.origin.x + rect.size.width
        let topBounds = rect.origin.y
        let bottomBounds = rect.origin.y + rect.size.height
        
        if ((pointX <= rightBounds && pointX >= leftBounds) &&
            (pointY <= bottomBounds && pointY >= topBounds)) {
                return true
        }
        return false
    }
    
    public func midPointTo(point: CGPoint) -> CGPoint {
        let x1 = self.x, x2 = point.x
        let y1 = self.y, y2 = point.y
        
        let midX = (x1 + x2) * 0.5, midY = (y1 + y2) * 0.5
        
        return CGPoint(x: midX, y: midY)
    }
    
    init(origin: CGPoint, destination: CGPoint, proportion: CGFloat) {
        let originX = origin.x, originY = origin.y
        let destinationX = destination.x, destinationY = destination.y
        
        x = (originX + proportion * destinationX) / (1 + proportion)
        y = (originY + proportion * destinationY) / (1 + proportion)
    }
    
    public static func proportionForPoint(interpolatePoint: CGPoint, betweenPoints origin: CGPoint, destination: CGPoint) -> CGFloat {
        return (origin.y - interpolatePoint.y) / (interpolatePoint.y - destination.y)
    }
    
    public func mix(point: CGPoint, percentage: CGFloat) -> CGPoint {
        let mixedPoint = CGPointMake((self.x * (1 - percentage) + point.x * percentage),
            (self.y * (1 - percentage) + point.y * percentage))
        return mixedPoint
    }
}

extension CGPoint {
    public func pointWithX(x anX: CGFloat) -> CGPoint {
        return CGPoint(x: anX, y: y)
    }
    public func pointWithY(y aY: CGFloat) -> CGPoint {
        return CGPoint(x: x, y: aY)
    }
}

public func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

public func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}

public func * (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
    return CGPoint(x: lhs.x * rhs, y: lhs.y * rhs)
}
public func * (lhs: CGFloat, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs * rhs.x, y: lhs * rhs.y)
}
public func * (lhs: CGPoint, rhs: CGPoint) -> CGFloat {
    return  lhs.x * rhs.x + lhs.y * rhs.y
}

public func / (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
    return CGPoint(x: lhs.x / rhs, y: lhs.y / rhs)
}

