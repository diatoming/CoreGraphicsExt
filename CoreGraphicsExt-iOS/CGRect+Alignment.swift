//
//  CGRect+Alignment.swift
//  CoreGraphicsExt
//
//  Created by Manfred on 11/9/15.
//
//

import CoreGraphics

extension CGRectVerticalAnchor {
    public func ofRect(alignedRect: CGRect,
        alignTo side: CGRectVerticalAnchor,
        ofRect aligningRect: CGRect)
        -> CGRect
    {
        switch (self, side) {
        case (.Top, .Top):
            return CGRect(
                origin: CGPoint(x: alignedRect.minX, y: aligningRect.minY),
                size: alignedRect.size)
        case (.Top, .Mid):
            return CGRect(
                origin: CGPoint(x: alignedRect.minX, y: aligningRect.midY),
                size: alignedRect.size)
        case (.Top, .Bottom):
            return CGRect(
                origin: CGPoint(x: alignedRect.minX, y: aligningRect.maxY),
                size: alignedRect.size)
            
        case (.Bottom, .Bottom):
            let origin = CGPoint(x: alignedRect.minX,
                y: aligningRect.maxY - alignedRect.size.height)
            return CGRect(origin: origin, size: alignedRect.size)
        case (.Bottom, .Mid):
            let origin = CGPoint(x: alignedRect.minX,
                y: aligningRect.midX - alignedRect.size.height)
            return CGRect(origin: origin, size: alignedRect.size)
        case (.Bottom, .Top):
            let origin = CGPoint(x: alignedRect.minX,
                y: aligningRect.minY - alignedRect.size.height)
            return CGRect(origin: origin, size: alignedRect.size)
            
        case (.Mid, .Top):
            return CGRect(
                center: CGPoint(x: alignedRect.midX, y: aligningRect.minY),
                size: alignedRect.size)
        case (.Mid, .Mid):
            return CGRect(
                center: CGPoint(x: alignedRect.midX, y: aligningRect.midY),
                size: alignedRect.size)
        case (.Mid, .Bottom):
            return CGRect(
                center: CGPoint(x: alignedRect.midX, y: aligningRect.maxY),
                size: alignedRect.size)
        }
    }
}

extension CGRectHorizontalAnchor {
    public func ofRect(alignedRect: CGRect,
        alignTo side: CGRectHorizontalAnchor,
        ofRect aligningRect: CGRect)
        -> CGRect
    {
        switch (self, side) {
        case (.Left, .Left):
            return CGRect(
                origin: CGPoint(x: aligningRect.minX, y: alignedRect.minY),
                size: alignedRect.size)
        case (.Left, .Mid):
            return CGRect(
                origin: CGPoint(x: aligningRect.midX, y: alignedRect.minY),
                size: alignedRect.size)
        case (.Left, .Right):
            return CGRect(
                origin: CGPoint(x: aligningRect.maxX, y: alignedRect.minY),
                size: alignedRect.size)
            
        case (.Right, .Right):
            let origin = CGPoint(
                x: aligningRect.maxX - alignedRect.size.width,
                y: alignedRect.minY)
            return CGRect(origin: origin, size: alignedRect.size)
        case (.Right, .Mid):
            let origin = CGPoint(
                x: aligningRect.midX - alignedRect.size.width,
                y: alignedRect.minY)
            return CGRect(origin: origin, size: alignedRect.size)
        case (.Right, .Left):
            let origin = CGPoint(
                x: aligningRect.minX - alignedRect.size.width,
                y: alignedRect.minY)
            return CGRect(origin: origin, size: alignedRect.size)
            
        case (.Mid, .Left):
            return CGRect(
                center: CGPoint(x: aligningRect.minX, y: alignedRect.midY),
                size: alignedRect.size)
        case (.Mid, .Mid):
            return CGRect(
                center: CGPoint(x: aligningRect.midX, y: alignedRect.midY),
                size: alignedRect.size)
        case (.Mid, .Right):
            return CGRect(
                center: CGPoint(x: aligningRect.maxX, y: alignedRect.midY),
                size: alignedRect.size)
        }
    }
}