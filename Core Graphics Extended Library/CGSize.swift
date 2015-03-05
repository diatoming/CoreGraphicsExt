//
//  CGSize.swift
//  Core Graphics Extended Library
//
//  Created by Manfred Lau on 10/18/14.
//
//

import CoreGraphics

extension CGSize {
    public static var zero: CGSize {
        return CGSizeZero
    }
    
    public static var max: CGSize {
        return CGSize(width: CGFloat.max, height: CGFloat.max)
    }
}

extension CGSize {
    public var minSideLength: CGFloat {
        return Swift.min(width, height)
    }
    public var maxSideLength: CGFloat {
        return Swift.max(width, height)
    }
    public var integeral: CGSize {
        return CGSize(width: ceil(width), height: ceil(height))
    }
}

extension CGSize {
    public func mix(size: CGSize, percentage: CGFloat) -> CGSize {
        let size = CGSize(width: (self.width * (1 - percentage) + size.width * percentage),
            height: (self.height * (1 - percentage) + size.height * percentage))
        return size
    }
}

public func + (lhs: CGSize, rhs: CGSize) -> CGSize {
    return CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
}

public func - (lhs: CGSize, rhs: CGSize) -> CGSize {
    return CGSize(width: lhs.width - rhs.width, height: lhs.height - rhs.height)
}

public func * (lhs: CGSize, rhs: CGFloat) -> CGSize {
    return CGSize(width: lhs.width * rhs, height: lhs.height * rhs)
}
public func * (lhs: CGFloat, rhs: CGSize) -> CGSize {
    return CGSize(width: lhs * rhs.width, height: lhs * rhs.height)
}

public func / (lhs: CGSize, rhs: CGFloat) -> CGSize {
    return CGSize(width: lhs.width / rhs, height: lhs.height / rhs)
}

public func / (lhs: CGSize, rhs: Int) -> CGSize {
    return CGSize(width: lhs.width / CGFloat(rhs), height: lhs.height / CGFloat(rhs))
}
