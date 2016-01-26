//
//  CGGeometry+AlignToScreenPixels.swift
//  Core-Graphics-Extended-Library
//
//  Created by Manfred on 7/6/15.
//
//

import CoreGraphics

public enum CGUnaryGeometryScreenPixelAlignment: Int {
    case Ceil, Floor, Round
}

public enum CGBinaryGeometryScreenPixelAlignment: Int {
    case Extend, Round, Shrink
}

extension CGFloat {
    public func alignToScreenPixels(
        alignment: CGUnaryGeometryScreenPixelAlignment = .Round
        )
        -> CGFloat
    {
        if let screenScale = CGScreenScale() {
            switch alignment {
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
        alignment: CGUnaryGeometryScreenPixelAlignment = .Round
        )
        -> CGPoint
    {
        if let screenScale = CGScreenScale() {
            switch alignment {
            case .Ceil:
                return CGPoint(
                    x: ceil(x * screenScale) / screenScale,
                    y: ceil(y * screenScale) / screenScale
                )
            case .Floor:
                return CGPoint(
                    x: floor(x * screenScale) / screenScale,
                    y: floor(y * screenScale) / screenScale
                )
            case .Round:
                return CGPoint(
                    x: round(x * screenScale) / screenScale,
                    y: round(y * screenScale) / screenScale
                )
            }
        } else {
            return CGPoint(x: Int(x), y: Int(y))
        }
    }
}

extension CGSize {
    public func alignToScreenPixels(
        alignment: CGUnaryGeometryScreenPixelAlignment = .Round
        )
        -> CGSize
    {
        if let screenScale = CGScreenScale() {
            switch alignment {
            case .Ceil:
                return CGSize(
                    width: ceil(width * screenScale) / screenScale,
                    height: ceil(height * screenScale) / screenScale
                )
            case .Floor:
                return CGSize(
                    width: floor(width * screenScale) / screenScale,
                    height: floor(height * screenScale) / screenScale
                )
            case .Round:
                return CGSize(
                    width: round(width * screenScale) / screenScale,
                    height: round(height * screenScale) / screenScale
                )
            }
        } else {
            return CGSize(width: Int(width), height: Int(height))
        }
    }
}

extension CGRect {
    #if os(iOS) || os(tvOS) || os(watchOS)
    public func alignToScreenPixels(
        alignment: CGBinaryGeometryScreenPixelAlignment = .Extend
        )
        -> CGRect
    {
        if let screenScale = CGScreenScale() {
            switch alignment {
            case .Extend:
                return CGRect(
                    x: floor(origin.x * screenScale) / screenScale,
                    y: floor(origin.y * screenScale) / screenScale,
                    width: ceil(size.width * screenScale) / screenScale,
                    height: ceil(size.height * screenScale) / screenScale
                )
            case .Round:
                return CGRect(
                    x: round(origin.x * screenScale) / screenScale,
                    y: round(origin.y * screenScale) / screenScale,
                    width: round(size.width * screenScale) / screenScale,
                    height: round(size.height * screenScale) / screenScale
                )
            case .Shrink:
                return CGRect(
                    x: ceil(origin.x * screenScale) / screenScale,
                    y: ceil(origin.y * screenScale) / screenScale,
                    width: floor(size.width * screenScale) / screenScale,
                    height: floor(size.height * screenScale) / screenScale
                )
            }
        } else {
            return CGRect(
                x: Int(origin.x), y: Int(origin.y),
                width: Int(width), height: Int(height)
            )
        }
    }
    #elseif os(OSX)
    public func alignToScreenPixels(
        alignment: CGBinaryGeometryScreenPixelAlignment = .Extend
        )
        -> CGRect
    {
        if let screenScale = CGScreenScale() {
            switch alignment {
            case .Extend:
                return CGRect(
                    x: ceil(origin.x * screenScale) / screenScale,
                    y: ceil(origin.y * screenScale) / screenScale,
                    width: floor(size.width * screenScale) / screenScale,
                    height: floor(size.height * screenScale) / screenScale
                )
            case .Round:
                return CGRect(
                    x: round(origin.x * screenScale) / screenScale,
                    y: round(origin.y * screenScale) / screenScale,
                    width: round(size.width * screenScale) / screenScale,
                    height: round(size.height * screenScale) / screenScale
                )
            case .Shrink:
                return CGRect(
                    x: floor(origin.x * screenScale) / screenScale,
                    y: floor(origin.y * screenScale) / screenScale,
                    width: ceil(size.width * screenScale) / screenScale,
                    height: ceil(size.height * screenScale) / screenScale
                )
            }
        } else {
            return CGRect(
                x: Int(origin.x), y: Int(origin.y),
                width: Int(width), height: Int(height)
            )
        }
    }
    #endif
}