//
//  UI+Extensions.swift
//  letter_mouse
//
//  Created by bleo on 2020/02/23.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

extension UIColor {
    ///
    /// Returns the image at the specified color it is size within 1x1
    ///
    var minimalImage: UIImage? {
        return toRectangularImage(size: CGSize(width: 1, height: 1))
    }

    func toRectangularImage(size: CGSize) -> UIImage? {
        let color = self
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        defer { UIGraphicsEndImageContext() }
        color.setFill()
        UIRectFill(CGRect(origin: .zero, size: size))
        return UIGraphicsGetImageFromCurrentImageContext()
    }

    func toCornerRoundedImage(size: CGSize) -> UIImage? {
        let color = self
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        defer { UIGraphicsEndImageContext() }
        let context = UIGraphicsGetCurrentContext()
        color.setFill()
        let rect = CGRect(origin: .zero, size: size)

        let path = UIBezierPath(roundedRect: rect, cornerRadius: min(size.width, size.height))
        path.close()
        context?.addPath(path.cgPath)
        context?.drawPath(using: .fill)

        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

extension CALayer {
    func drawBorder(with color: UIColor, width: CGFloat) {
        self.borderColor = color.cgColor
        self.borderWidth = width
    }
}

extension UIImage {
    convenience init?(view: UIView) {
        UIGraphicsBeginImageContext(view.frame.size)
        defer { UIGraphicsEndImageContext() }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        view.layer.render(in: context)
        guard let cgImage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }

    convenience init?(cgImage: CGImage?) {
        guard let cgImage = cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}

extension UIView {
    func drawBorder(with color: UIColor, width: CGFloat) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }

    func drawShadow(color: UIColor = UIColor.black, offset: CGSize = CGSize(width: 0.0, height: 0.5), opacity: Float = 0.15, radius: CGFloat = 2.0) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
    }
    
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}

extension CGPoint {
    static var upperLeft: CGPoint {
        return .zero
    }
    static var upperRight: CGPoint {
        return CGPoint(x: 1.0, y: 0.0)
    }
    static var lowerLeft: CGPoint {
        return CGPoint(x: 0.0, y: 1.0)
    }
    static var lowerRight: CGPoint {
        return CGPoint(x: 1.0, y: 1.0)
    }

    static var centerLeft: CGPoint {
        return CGPoint(x: 0.0, y: 0.5)
    }
    static var centerRight: CGPoint {
        return CGPoint(x: 1.0, y: 0.5)
    }
    static var upperCenter: CGPoint {
        return CGPoint(x: 0.5, y: 0.0)
    }
    static var lowerCenter: CGPoint {
        return CGPoint(x: 0.5, y: 1.0)
    }

    static var center: CGPoint {
        return CGPoint(x: 0.5, y: 0.5)
    }

    static var one: CGPoint {
        return CGPoint(x: 1.0, y: 1.0)
    }

    static var toRight: (CGPoint, CGPoint) {
        return (.centerLeft, .centerRight)
    }

    static var toTop: (CGPoint, CGPoint) {
        return (.lowerCenter, .upperCenter)
    }

    static var toBottom: (CGPoint, CGPoint) {
        return (.upperCenter, .lowerCenter)
    }
}

extension CGSize {
    static func *(lhs: CGSize, ratio: CGFloat) -> CGSize {
        return CGSize(width: lhs.width * ratio, height: lhs.height * ratio)
    }

    static func *(ratio: CGFloat, rhs: CGSize) -> CGSize {
        return CGSize(width: rhs.width * ratio, height: rhs.height * ratio)
    }
}
