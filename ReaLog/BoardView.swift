//
//  LogView.swift
//  ReaLog
//
//  Created by PointerFLY on 09/02/2017.
//  Copyright © 2017 PointerFLY. All rights reserved.
//

import UIKit

class BoardView: UIVisualEffectView {

    static let shared = BoardView()

    var minimizeAction: (() -> Void)?

    init() {
        super.init(effect: UIBlurEffect(style: .dark))
        self.isUserInteractionEnabled = true

        self.frame = CGRect(x: 20, y: 160, width: 260, height: 260)
        self.layer.cornerRadius = 12.0
        self.clipsToBounds = true
    
        self.addSubview(textView)
        self.addSubview(_minimizeButton)
        self.addSubview(_maximizeButton)
        self.addSubview(_dragAreaView)
        self.addSubview(_scaleAreaView)

        addEvents()
    }

    private func addEvents() {
        _minimizeButton.addTarget(self, action: #selector(minimizeButtonClicked(_:)), for: .touchUpInside)
        _maximizeButton.addTarget(self, action: #selector(maximizeButtonClicked(_:)), for: .touchUpInside)

        let dragPan = UIPanGestureRecognizer(target: self, action: #selector(handleDragPan(_:)))
        self._dragAreaView.addGestureRecognizer(dragPan)

        let scalePan = UIPanGestureRecognizer(target: self, action: #selector(handleScalePan(_:)))
        self._scaleAreaView.addGestureRecognizer(scalePan)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let viewWidth = self.bounds.width
        let viewHeight = self.bounds.height

        textView.frame = CGRect(x: 10, y: 42, width: viewWidth - 10 * 2, height: viewHeight - 42 - 10)
        _dragAreaView.frame = CGRect(x: 80, y: 0, width: viewWidth - 80, height: 42)
        _scaleAreaView.frame = CGRect(x: viewWidth - 36, y: viewHeight - 36, width: 36, height: 36)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private var _dragStartOffset = CGPoint.zero
    private var _originalSize = CGSize.zero
    private let _minSize = CGSize(width: 200, height: 140)

    @objc
    private func handleDragPan(_ gesture: UIPanGestureRecognizer) {
        if gesture.state == .began {
            let position = gesture.location(in: self)
            let offsetX = position.x - self.bounds.width / 2.0
            let offsetY = position.y - self.bounds.height / 2.0
            _dragStartOffset = CGPoint(x: offsetX, y: offsetY)
        } else if gesture.state == .changed {
            let previousCenter = self.center

            // Move with gesture
            let location = gesture.location(in: self.superview)
            self.center = CGPoint(x: location.x - _dragStartOffset.x, y: location.y - _dragStartOffset.y)

            // Prevent the whole drag area goes out of screen
            let intersection = UIScreen.main.bounds.intersection(self.convert(_dragAreaView.frame, to: self.superview))
            if !(intersection.size.width > 50 && intersection.size.height > 36) {
                self.center = previousCenter
            }
        }
    }

    @objc
    private func handleScalePan(_ gesture: UIPanGestureRecognizer) {
        if gesture.state == .began {
            _originalSize = self.bounds.size
        } else if gesture.state == .changed {
            let movement = gesture.translation(in: self)

            var newWidth = _originalSize.width + movement.x
            var newHeight = _originalSize.height + movement.y

            // Prevent the edge goes out of screen
            if newWidth < _minSize.width || newWidth + self.frame.origin.x >= UIScreen.main.bounds.width {
                newWidth = self.frame.size.width
            }
            if newHeight < _minSize.height || newHeight + self.frame.origin.y >= UIScreen.main.bounds.height  {
                newHeight = self.frame.size.height
            }

            self.frame.size = CGSize(width: newWidth, height: newHeight)
        }
    }

    @objc
    private func minimizeButtonClicked(_ sender: MinimizeButton) {
        minimizeAction?()
    }

    private var _isMaximized = false

    @objc
    private func maximizeButtonClicked(_ sender: MaximizeButton) {
        _isMaximized = !_isMaximized
        if !_isMaximized {
            self.frame = CGRect(x: 20, y: 160, width: 260, height: 260)
            self.clipsToBounds = true
            _dragAreaView.isUserInteractionEnabled = true
            _scaleAreaView.isUserInteractionEnabled = true
        } else {
            self.frame = UIScreen.main.bounds
            self.clipsToBounds = false
            _dragAreaView.isUserInteractionEnabled = false
            _scaleAreaView.isUserInteractionEnabled = false
        }
    }

    private let _minimizeButton: MinimizeButton = {
        let button = MinimizeButton(frame: CGRect(x: 8, y: 8, width: 28, height: 28))
        return button
    }()

    private let _maximizeButton: MaximizeButton = {
        let button = MaximizeButton(frame: CGRect(x: 45, y: 8, width: 28, height: 28))
        return button
    }()

    private let _dragAreaView: UIView = {
        let view = UIView(frame: CGRect(x: 80, y: 0, width: 200, height: 40))
//        view.backgroundColor = UIColor.red
        return view
    }()

    private let _scaleAreaView: UIView = {
        let view = UIView(frame: CGRect(x: 230, y: 230, width: 36, height: 36))
        return view
    }()

    let textView: UITextView = {
        let view = UITextView(frame: CGRect(x: 10, y: 42, width: 240, height: 210))
        view.isEditable = false
        view.backgroundColor = UIColor.clear
        view.textColor = UIColor.white
        view.isSelectable = false
        view.layoutManager.allowsNonContiguousLayout = false
        return view
    }()
}

