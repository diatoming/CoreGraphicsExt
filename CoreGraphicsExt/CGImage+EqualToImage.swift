//
//  CGImage+EqualToImage.swift
//  CoreGraphicsExt
//
//  Created by Manfred on 11/25/15.
//
//

import CoreGraphics
#if os(iOS) || os(tvOS) || os(watchOS)
    import UIKit
#elseif os(OSX)
    import AppKit
#endif

extension CGImage {
    public func isEqualToImage(image: CGImage) -> Bool {
        return CGImageIsEqualToImage(self, rhs: image)
    }
}

public func CGImageIsEqualToImage(lhs: CGImage, rhs: CGImage) -> Bool {
    if lhs === rhs { return true }
    
    #if os(iOS) || os(tvOS) || os(watchOS)
        let lhsUIImage = UIImage(CGImage: lhs)
        let rhsUIImage = UIImage(CGImage: rhs)
        
        guard let
            lhsPNGData = UIImagePNGRepresentation(lhsUIImage),
            rhsPNGData = UIImagePNGRepresentation(rhsUIImage) else
        {
            return false
        }
        
        return lhsPNGData.isEqualToData(rhsPNGData)
    #elseif os(OSX)
        let lhsSize = CGSize(width: CGFloat(CGImageGetWidth(lhs)),
            height: CGFloat(CGImageGetHeight(lhs)))
        let rhsSize = CGSize(width: CGFloat(CGImageGetWidth(rhs)),
            height: CGFloat(CGImageGetHeight(rhs)))
        
        let lhsNSImage = NSImage(CGImage: lhs, size: lhsSize)
        let rhsNSImage = NSImage(CGImage: lhs, size: rhsSize)
        
        guard let
            lhsTIFFData = lhsNSImage.TIFFRepresentation,
            rhsTIFFData = rhsNSImage.TIFFRepresentation else
        {
            return false
        }
        
        return lhsTIFFData.isEqualToData(rhsTIFFData)
    #endif
}
