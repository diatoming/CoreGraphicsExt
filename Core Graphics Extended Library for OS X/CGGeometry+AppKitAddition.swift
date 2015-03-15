//
//  CGGeometry+AppKitAddition.swift
//  Core Graphics Extended Library
//
//  Created by Manfred Lau on 3/15/15.
//
//

import Cocoa

enum ScreenPixelAlignmentPolicy: Int {
    case Ceil, Floor
}

extension CGFloat {
    func alignToScreenPixel(policy: ScreenPixelAlignmentPolicy) -> CGFloat {
        if let screenScale = NSScreen.mainScreen()?.backingScaleFactor {
            switch policy {
            case .Ceil:
                return ceil(self * screenScale) / screenScale
            case .Floor:
                return ceil(self * screenScale) / screenScale
            default:
                return self
            }
        } else {
            return self
        }
    }
}

extension CGPoint {
    func alignToScreenPixel(policy: ScreenPixelAlignmentPolicy) -> CGPoint {
        if let screenScale = NSScreen.mainScreen()?.backingScaleFactor {
            switch policy {
            case .Ceil:
                return CGPoint(x: ceil(self.x * screenScale) / screenScale, y: ceil(self.y * screenScale) / screenScale)
            case .Floor:
                return CGPoint(x: floor(self.x * screenScale) / screenScale, y: floor(self.y * screenScale) / screenScale)
            default:
                return self
            }
        } else {
            return self
        }
    }
}

extension CGSize {
    func alignToScreenPixel(policy: ScreenPixelAlignmentPolicy) -> CGSize {
        if let screenScale = NSScreen.mainScreen()?.backingScaleFactor {
            switch policy {
            case .Ceil:
                return CGSize(width: ceil(self.width * screenScale) / screenScale, height: ceil(self.height * screenScale) / screenScale)
            case .Floor:
                return CGSize(width: floor(self.width * screenScale) / screenScale, height: floor(self.height * screenScale) / screenScale)
            default:
                return self
            }
        } else {
            return self
        }
    }
}

extension CGRect {
    func alignToScreenPixel(policy: ScreenPixelAlignmentPolicy) -> CGRect {
        if let screenScale = NSScreen.mainScreen()?.backingScaleFactor {
            switch policy {
            case .Ceil:
                return CGRect(x: ceil(self.origin.x * screenScale) / screenScale,
                    y: ceil(self.origin.y * screenScale) / screenScale,
                    width: ceil(self.size.width * screenScale) / screenScale,
                    height: ceil(self.size.height * screenScale) / screenScale)
            case .Floor:
                return CGRect(x: floor(self.origin.x * screenScale) / screenScale,
                    y: floor(self.origin.y * screenScale) / screenScale,
                    width: floor(self.size.width * screenScale) / screenScale,
                    height: floor(self.size.height * screenScale) / screenScale)
            default:
                return self
            }
        } else {
            return self
        }
    }
}