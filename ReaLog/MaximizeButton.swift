//
//  MaximizeButton.swift
//  ReaLog
//
//  Created by PointerFLY on 10/02/2017.
//  Copyright © 2017 PointerFLY. All rights reserved.
//

import UIKit

class MaximizeButton: UIButton {

    override init(frame: CGRect) {
        _maximizeSymbol = MaximizeSymbol()
        _maximizeSymbol.frame.size = frame.size
        _maximizeSymbol.center = CGPoint(x: frame.width / 2.0, y: frame.height / 2.0)

        super.init(frame: frame)
        self.setImage(UIImage.imageWithColor(UIColor(r: 40, g: 207, b: 66), size: frame.size), for: .normal)
        self.setImage(UIImage.imageWithColor(UIColor(r: 30, g: 160, b: 46), size: frame.size), for: .selected)

        self.addSubview(_maximizeSymbol)
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()

        self.layer.cornerRadius = self.frame.width / 2.0
        self.clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let _maximizeSymbol: MaximizeSymbol
}

private class MaximizeSymbol: UIView {

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

        context.move(to: CGPoint(x: size.width / 2.0, y: size.height * 0.2))
        context.addLine(to: CGPoint(x: size.width / 2.0, y: size.height * 0.8))

        context.strokePath()
    }
}
