//
//  ScreenPixelAlignment-WatchKit.swift
//  CoreGraphicsExt
//
//  Created by Manfred on 11/17/15.
//
//

import WatchKit

func CGScreenScale() -> CGFloat? {
    return WKInterfaceDevice.currentDevice().screenScale
}
