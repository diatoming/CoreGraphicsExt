//
//  CGSize.swift
//  Core Graphics Extended Library
//
//  Created by Manfred Lau on 10/18/14.
//
//

import CoreGraphics

extension CGSize {
    /// Create a CGSize value with maximum width and height
    public static var max: CGSize {
        return CGSize(width: CGFloat.max, height: CGFloat.max)
    }
}

extension CGSize {
    /// Get minimum side length
    public var minSideLength: CGFloat {
        return Swift.min(width, height)
    }
    
    /// Get maximum side length
    public var maxSideLength: CGFloat {
        return Swift.max(width, height)
    }
    
    /// Integral
    public var integral: CGSize {
        return CGSize(width: ceil(width), height: ceil(height))
    }
    
    public mutating func makeIntegralInPlace() {
        self = CGSize(width: ceil(width), height: ceil(height))
    }
    
    /// Swap width and height
    public func swapDimension() -> CGSize {
        return CGSize(width: height, height: width)
    }
    
    /// Swap width and height in place
    public mutating func swapDimensionInPlace() {
        self = CGSize(width: height, height: width)
    }
}

extension CGSize {
    /// Linear mix the size with the given size and percentage
    public func mix(size: CGSize, percentage: CGFloat) -> CGSize {
        let width = (self.width * (1 - percentage) +
            size.width * percentage)
        let height = (self.height * (1 - percentage) +
            size.height * percentage)
        let size = CGSize(width: width, height: height)
        return size
    }
}

public func + (lhs: CGSize, rhs: CGSize) -> CGSize {
    return CGSize(width: lhs.width + rhs.width,
        height: lhs.height + rhs.height)
}

public func += (inout lhs: CGSize, rhs: CGSize) {
    lhs = CGSize(width: lhs.width + rhs.width,
        height: lhs.height + rhs.height)
}

public func - (lhs: CGSize, rhs: CGSize) -> CGSize {
    return CGSize(width: lhs.width - rhs.width,
        height: lhs.height - rhs.height)
}

public func -= (inout lhs: CGSize, rhs: CGSize) {
    lhs = CGSize(width: lhs.width - rhs.width,
        height: lhs.height - rhs.height)
}

public func * (lhs: CGSize, rhs: CGFloat) -> CGSize {
    return CGSize(width: lhs.width * rhs,
        height: lhs.height * rhs)
}

public func *= (inout lhs: CGSize, rhs: CGFloat) {
    lhs = CGSize(width: lhs.width * rhs,
        height: lhs.height * rhs)
}

public func * (lhs: CGFloat, rhs: CGSize) -> CGSize {
    return CGSize(width: lhs * rhs.width,
        height: lhs * rhs.height)
}

public func / (lhs: CGSize, rhs: CGFloat) -> CGSize {
    return CGSize(width: lhs.width / rhs,
        height: lhs.height / rhs)
}

public func /= (inout lhs: CGSize, rhs: CGFloat) {
    lhs = CGSize(width: lhs.width / rhs,
        height: lhs.height / rhs)
}
