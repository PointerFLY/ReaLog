//
//  Extensions.swift
//  ReaLog
//
//  Created by PointerFLY on 10/02/2017.
//  Copyright © 2017 PointerFLY. All rights reserved.
//

import Foundation

extension UIColor {
    convenience init(rl_r r: UInt8, g: UInt8, b: UInt8, a: CGFloat = 1.0) {
        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: a)
    }
}

extension UIImage {
    static func rl_imageWithColor(_ color: UIColor, size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()!
        let rect = CGRect(origin: CGPoint.zero, size: size)
        context.setFillColor(color.cgColor)
        context.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
