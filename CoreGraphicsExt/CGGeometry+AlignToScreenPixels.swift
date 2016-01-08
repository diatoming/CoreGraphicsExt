//
//  CGGeometry+AlignToScreenPixels.swift
//  Core-Graphics-Extended-Library
//
//  Created by Manfred on 7/6/15.
//
//

import CoreGraphics

public enum ScreenPixelAlignmentPolicy: Int {
    case Ceil, Floor, Round
}

extension CGFloat {
    public func alignToScreenPixels(
        alignmentPolicy: ScreenPixelAlignmentPolicy = .Round)
        -> CGFloat
    {
        if let screenScale = CGScreenScale() {
            switch alignmentPolicy {
            case .Ceil:
                return ceil(self * screenScale) / screenScale
            case .Floor:
                return ceil(self * screenScale) / screenScale
            case .Round:
                return round(self * screenScale) / screenScale
            }
        }
        return CGFloat(Int(self))
    }
}

extension CGPoint {
    public func alignToScreenPixels(
        alignmentPolicy: ScreenPixelAlignmentPolicy = .Round)
        -> CGPoint
    {
        if let screenScale = CGScreenScale() {
            switch alignmentPolicy {
            case .Ceil:
                return CGPoint(x: ceil(x * screenScale) / screenScale,
                    y: ceil(y * screenScale) / screenScale)
            case .Floor:
                return CGPoint(x: floor(x * screenScale) / screenScale,
                    y: floor(y * screenScale) / screenScale)
            case .Round:
                return CGPoint(x: round(x * screenScale) / screenScale,
                    y: round(y * screenScale) / screenScale)
            }
        } else {
            return CGPoint(x: Int(x), y: Int(y))
        }
    }
}

extension CGSize {
    public func alignToScreenPixels(
        alignmentPolicy: ScreenPixelAlignmentPolicy = .Round)
        -> CGSize
    {
        if let screenScale = CGScreenScale() {
            switch alignmentPolicy {
            case .Ceil:
                return CGSize(width: ceil(width * screenScale) / screenScale,
                    height: ceil(height * screenScale) / screenScale)
            case .Floor:
                return CGSize(width: floor(width * screenScale) / screenScale,
                    height: floor(height * screenScale) / screenScale)
            case .Round:
                return CGSize(width: round(width * screenScale) / screenScale,
                    height: round(height * screenScale) / screenScale)
            }
        } else {
            return CGSize(width: Int(width),
                height: Int(height))
        }
    }
}

extension CGRect {
    public func alignToScreenPixels(
        alignmentPolicy: ScreenPixelAlignmentPolicy = .Round)
        -> CGRect
    {
        if let screenScale = CGScreenScale() {
            switch alignmentPolicy {
            case .Ceil:
                return CGRect(x: ceil(origin.x * screenScale) / screenScale,
                    y: ceil(origin.y * screenScale) / screenScale,
                    width: ceil(size.width * screenScale) / screenScale,
                    height: ceil(size.height * screenScale) / screenScale)
            case .Floor:
                return CGRect(x: floor(origin.x * screenScale) / screenScale,
                    y: floor(origin.y * screenScale) / screenScale,
                    width: floor(size.width * screenScale) / screenScale,
                    height: floor(size.height * screenScale) / screenScale)
            case .Round:
                return CGRect(x: round(origin.x * screenScale) / screenScale,
                    y: round(origin.y * screenScale) / screenScale,
                    width: round(size.width * screenScale) / screenScale,
                    height: round(size.height * screenScale) / screenScale)
            }
        } else {
            return CGRect(x: Int(origin.x), y: Int(origin.y),
                width: Int(width), height: Int(height))
        }
    }
}