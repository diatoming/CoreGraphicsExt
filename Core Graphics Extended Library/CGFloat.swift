//
//  CGFloat.swift
//  Core Graphics Extended Library
//
//  Created by Manfred Lau on 10/18/14.
//
//

import CoreGraphics

extension CGFloat {
    public func mix(mixedValue: CGFloat, percentage: CGFloat) -> CGFloat {
        return (self * (1 - percentage) + mixedValue * percentage);
    }
}
