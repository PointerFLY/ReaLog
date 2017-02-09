//
//  ReaLogView.swift
//  Example
//
//  Created by PointerFLY on 07/02/2017.
//  Copyright © 2017 PointerFLY. All rights reserved.
//

import UIKit

class FloatingBallView: UIVisualEffectView {

    init() {
        super.init(effect: UIBlurEffect(style: .dark))

        self.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        self.layer.allowsEdgeAntialiasing = true
        self.layer.cornerRadius = 12.0
        self.clipsToBounds = true

        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(dragging(_:)))
        panGestureRecognizer.maximumNumberOfTouches = 1
        self.addGestureRecognizer(panGestureRecognizer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func dragging(_ sender: UIPanGestureRecognizer) {
        let location = sender.location(in: self.superview)
        self.center = location
    }
}

