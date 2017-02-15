//
//  MinimizeButton.swift
//  ReaLog
//
//  Created by PointerFLY on 10/02/2017.
//  Copyright © 2017 PointerFLY. All rights reserved.
//

import UIKit

class MinimizeButton: UIButton {

    override init(frame: CGRect) {
        _minimizeSymbol = MinimizeSymbol()
        _minimizeSymbol.frame.size = frame.size
        _minimizeSymbol.center = CGPoint(x: frame.width / 2.0, y: frame.height / 2.0)

        super.init(frame: frame)
        self.setImage(UIImage.imageWithColor(UIColor(r: 255, g: 196, b: 48), size: frame.size), for: .normal)
        self.setImage(UIImage.imageWithColor(UIColor(r: 191, g: 145, b: 35), size: frame.size), for: .selected)

        self.addSubview(_minimizeSymbol)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()

        self.layer.cornerRadius = self.frame.width / 2.0
        self.clipsToBounds = true
    }

    private let _minimizeSymbol: MinimizeSymbol

    private class MinimizeSymbol: UIView {

        override init(frame: CGRect) {
            super.init(frame: frame)
            self.backgroundColor = UIColor.clear
            self.isUserInteractionEnabled = false
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override func draw(_ rect: CGRect) {
            let size = self.frame.size
            let context = UIGraphicsGetCurrentContext()!

            context.setLineWidth(1.0)
            context.setStrokeColor(UIColor(r: 0, g: 0, b: 0, a: 0.6).cgColor)

            context.move(to: CGPoint(x: size.width * 0.2, y: size.height / 2.0))
            context.addLine(to: CGPoint(x: size.width * 0.8, y: size.height / 2.0))
            context.strokePath()
        }
    }
}
