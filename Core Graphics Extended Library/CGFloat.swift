//
//  CGFloat.swift
//  Core Graphics Extended Library
//
//  Created by Manfred Lau on 10/18/14.
//
//

import CoreGraphics

extension CGFloat {
    /// Linear mix the CGFloat value with the given value and percentage
    public func mix(mixedValue: CGFloat, percentage: CGFloat) -> CGFloat {
        return (self * (1 - percentage) + mixedValue * percentage);
    }
}
