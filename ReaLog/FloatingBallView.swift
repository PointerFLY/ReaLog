//
//  ReaLogView.swift
//  Example
//
//  Created by PointerFLY on 07/02/2017.
//  Copyright © 2017 PointerFLY. All rights reserved.
//

import UIKit

class FloatingBallView: UIVisualEffectView {

    private let _sideLength: CGFloat = 60.0
    private var _startOffset = CGPoint.zero

    var tapAction: (() -> Void)?

    init() {
        super.init(effect: UIBlurEffect(style: .dark))

        self.frame = CGRect(x: 2.0, y: 200, width: _sideLength, height: _sideLength)
        self.layer.allowsEdgeAntialiasing = true
        self.layer.cornerRadius = 12.0
        self.clipsToBounds = true

        addEvents()
    }


    private func addEvents() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        self.addGestureRecognizer(tap)

        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        pan.maximumNumberOfTouches = 1
        self.addGestureRecognizer(pan)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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
            // Move with gesture
            let location = gesture.location(in: self.superview)
            self.center = CGPoint(x: location.x - _startOffset.x, y: location.y - _startOffset.y)
        } else if gesture.state == .ended {
            // Prevent the ball be moved out of superview's boundary

            let maxY = self.superview!.bounds.height
            let maxX = self.superview!.bounds.width

            var targetCenter = CGPoint.zero
            var inset: CGFloat = 2.0

            if self.frame.minX < inset && self.frame.minY < inset {
                targetCenter = CGPoint(x: _sideLength / 2.0 + inset, y: _sideLength / 2.0 + inset)
            } else if self.frame.maxX > maxX && self.frame.maxY > maxY {
                targetCenter = CGPoint(x: maxX - _sideLength / 2.0  - inset, y: maxY - _sideLength / 2.0 - inset)
            } else if self.frame.maxX > maxX && self.frame.minY < 0 {
                targetCenter = CGPoint(x: maxX - _sideLength / 2.0 - inset, y: _sideLength / 2.0 + inset)
            } else if self.frame.minX < inset && self.frame.maxY > maxY {
                targetCenter = CGPoint(x: _sideLength / 2.0 + inset, y: maxY - _sideLength / 2.0 - inset)
            } else if self.frame.minX < inset {
                targetCenter = CGPoint(x: _sideLength / 2.0 + inset, y: self.center.y)
            } else if self.frame.maxX > maxX {
                targetCenter = CGPoint(x: maxX - _sideLength / 2.0 - inset, y: self.center.y)
            } else if self.frame.minY < inset {
                targetCenter = CGPoint(x: self.center.x, y: _sideLength / 2.0 + inset)
            } else if self.frame.maxY > maxY {
                targetCenter = CGPoint(x: self.center.x, y: maxY - _sideLength / 2.0 - inset)
            } else {
                return
            }

            UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseOut, animations: {
                self.center = targetCenter
            }, completion: nil)
        }
    }
}

