//
//  CGGeometry+AppKitAddition.swift
//  Core Graphics Extended Library
//
//  Created by Manfred Lau on 3/15/15.
//
//

import Cocoa

func screenScale() -> CGFloat? {
    return NSScreen.mainScreen()?.backingScaleFactor
}
