//
//  CGPath+Equatable.swift
//  CoreGraphicsExt
//
//  Created by Manfred on 11/17/15.
//
//

import CoreGraphics

extension CGPath: Equatable {
    
}

public func == (lhs: CGPath, rhs: CGPath) -> Bool {
    return CGPathEqualToPath(lhs, rhs)
}
