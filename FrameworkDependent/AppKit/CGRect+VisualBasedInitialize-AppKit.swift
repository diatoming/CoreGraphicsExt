//
//  CGRect+VisualBasedInitialize-AppKit.swift
//  CoreGraphicsExt
//
//  Created by Manfred on 11/19/15.
//
//

import CoreGraphics

extension CGRect {
    /// Create a CGRect value with given vertices parameters
    public init(top: CGFloat, right: CGFloat, bottom: CGFloat, left: CGFloat) {
        origin = CGPointMake(right, bottom)
        size = CGSize(width: right - left, height: top - bottom)
    }
}
