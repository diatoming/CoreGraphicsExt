//
//  ScreenPixelAlignment+WatchKit.swift
//  CoreGraphicsExt
//
//  Created by Manfred on 11/17/15.
//
//

import WatchKit

func screenScale() -> CGFloat? {
    return WKInterfaceDevice.currentDevice().screenScale
}
