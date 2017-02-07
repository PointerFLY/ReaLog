//
//  ReaLogView.swift
//  Example
//
//  Created by PointerFLY on 07/02/2017.
//  Copyright © 2017 PointerFLY. All rights reserved.
//

import UIKit

class ReaLogView: UIView {

    init() {
        super.init(frame: CGRect.zero)

        self.frame = CGRect(x: 100, y: 100, width: 100, height: 100)

        self.backgroundColor = UIColor.black
        self.alpha = 0.75

        let pan = UIPanGestureRecognizer(target: self, action: #selector(dragging(_:)))
        pan.maximumNumberOfTouches = 1
        self.addGestureRecognizer(pan)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func dragging(_ sender: UIPanGestureRecognizer) {
        let location = sender.location(in: self.superview)
        self.center = location
    }
}
