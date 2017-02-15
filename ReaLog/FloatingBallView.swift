//
//  ReaLogView.swift
//  Example
//
//  Created by PointerFLY on 07/02/2017.
//  Copyright © 2017 PointerFLY. All rights reserved.
//

import UIKit

class FloatingBallView: UIVisualEffectView {

    var tapAction: (() -> Void)?

    init() {
        super.init(effect: UIBlurEffect(style: .dark))

        self.layer.allowsEdgeAntialiasing = true
        self.layer.cornerRadius = 12.0
        self.clipsToBounds = true

        // Initialize position
        self.frame = CGRect(x: 1.0, y: UIScreen.main.bounds.height - _sideLength - 150, width: _sideLength, height: _sideLength)

        addEvents()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let _sideLength: CGFloat = 60.0
    private var _startOffset = CGPoint.zero

    private func addEvents() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        self.addGestureRecognizer(tap)

        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        self.addGestureRecognizer(pan)
    }

    // MARK: - Actions

    @objc
    private func handleTap(_ gesture: UITapGestureRecognizer) {
        tapAction?()
    }

    @objc
    private func handlePan(_ gesture: UIPanGestureRecognizer) {
        guard self.superview != nil else { return }

        if gesture.state == .began {
            // Start point may not be at the center
            let position = gesture.location(in: self)
            let offsetX = position.x - _sideLength / 2.0
            let offsetY = position.y - _sideLength / 2.0
            _startOffset = CGPoint(x: offsetX, y: offsetY)
        } else if gesture.state == .changed {
            let previousCenter = self.center

            // Move with gesture
            let location = gesture.location(in: self.superview)
            self.center = CGPoint(x: location.x - _startOffset.x, y: location.y - _startOffset.y)

            // Prevent too much area of ball goes out of screen
            let intersection = UIScreen.main.bounds.intersection(self.frame)
            if intersection.size.width < 50 {
                self.center.x = previousCenter.x
            }
            if intersection.size.height < 50 {
                self.center.y = previousCenter.y
            }
        }
    }
}

