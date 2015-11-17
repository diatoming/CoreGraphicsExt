//
//  ScreenPixelAlignment+AppKit.swift
//  CoreGraphicsExt
//
//  Created by Manfred on 11/17/15.
//
//

import AppKit

func screenScale() -> CGFloat? {
    return NSScreen.mainScreen()?.backingScaleFactor
}
