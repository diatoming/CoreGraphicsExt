//
//  CGGeometry+WatchKitAddition.swift
//  Core-Graphics-Extended-Library
//
//  Created by Manfred on 7/6/15.
//
//

import WatchKit

func screenScale() -> CGFloat? {
    return WKInterfaceDevice.currentDevice().screenScale
}
