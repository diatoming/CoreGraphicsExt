Core Graphics Extended Library is aiming to complete missing conveniences in Core Graphics.

# Get Started
- Download Core Graphics Extended Library
- Drag Core Graphics Extended Library’s Xcode project file to your workspace
- Add Core Graphics Extended Library to your`Emebed Binaries`  field in your target’s general page if you are building an app. Or add Core Graphics Extended Library to your `Linked Frameworks and Libraries` field in your target’s general page if you are building a framework.
- Add `import CoreGraphicsExt` to your Swift source file
- Enjoy your journey of Core Graphics Extended Library

# What This Library Extends With

## Linear Mixing
You can now linear mix CGFloat, CGPoint and CGSize now

## Geometric Position Detection
You can now check:
- If a `CGPoint` value is inside a circle which is the biggest circle inside the given `CGRect` value
- If a `CGPoint` value is on the circumference of a circle which is the biggest circle inside the given `CGRect` value
- If a `CGPoint` value is inside a `CGRect` value
- If a `CGPoint` value is on the circumference of a `CGRect` value
- If a `CGRect` value touches an other.

## More Conveniences on Value Creation
You can now create `CGRect` value with:
- Center and size
- Center, width and height
- A given CGRect value and optional origin and size
- `CGPoint` values which require created `CGRect` value to cover
- `CGRect` values which require created `CGRect` value to cover

You also can now create `CGRect` value by:
- Swapping width and height
- Modify a given `CGRect` value’s origin or size

You can now create `CGPoint` value with
- Definite proportion and seperated points

##Integral And Align to Screen Pixel
You can now integral CGFloat, CGPoint, CGSize and CGRect value by accessing their  `integral` property.

You can now algin CGFloat, CGPoint, CGSize and CGRect value to screen pixel by calling `func alignToScreenPixel(policy: ScreenPixelAlignmentPolicy)` function on those value.

## Arithmetic Operation on CGPoint And CGSize Value
You can `+`, `-` a CGPoint value with an other now.
You can `*`, `/` a CGPoint value with a CGFloat value now
You can make a dot product with two CGPoint values now.

You can `+`, `-` a CGSize value with an other now.
You can `*`, `/` a CGSize value with a CGFloat or an Int value now

##More Functionalities Can Be Found Inside The Library
- Get distance between two `CGPoint` values
- Get mid point between two `CGPoint` values
- Get max and min side length of `CGSize` value
- Enumerate each vertex on a `CGRect` value

# License
Core Graphics Extended Library is available under the MIT license. See the LICENSE file for more info.
