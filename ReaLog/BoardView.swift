//
//  LogView.swift
//  ReaLog
//
//  Created by PointerFLY on 09/02/2017.
//  Copyright © 2017 PointerFLY. All rights reserved.
//

import UIKit

class BoardView: UIVisualEffectView {

    var minimizeAction: (() -> Void)?
    let minSize = CGSize(width: 200, height: 140)

    init() {
        super.init(effect: UIBlurEffect(style: .dark))
        self.isUserInteractionEnabled = true

        self.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
        self.bounds.size = CGSize(width: 260, height: 260)
        self.layer.cornerRadius = 12.0
        self.clipsToBounds = true

        self.contentView.addSubview(logTextView)
        self.contentView.addSubview(_minimizeButton)
        self.contentView.addSubview(_maximizeButton)
        self.contentView.addSubview(_dragAreaView)
        self.contentView.addSubview(_scaleAreaView)

        addEvents()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let viewWidth = self.bounds.width
        let viewHeight = self.bounds.height

        logTextView.frame = CGRect(x: 10, y: 42, width: viewWidth - 10 * 2, height: viewHeight - 42 - 10)
        _dragAreaView.frame = CGRect(x: 80, y: 0, width: viewWidth - 80, height: 42)
        _scaleAreaView.frame = CGRect(x: viewWidth - 36, y: viewHeight - 36, width: 36, height: 36)
    }
    
    private var _dragStartOffset = CGPoint.zero
    private var _originalSize = CGSize.zero

    private func addEvents() {
        _minimizeButton.addTarget(self, action: #selector(minimizeButtonClicked(_:)), for: .touchUpInside)
        _maximizeButton.addTarget(self, action: #selector(maximizeButtonClicked(_:)), for: .touchUpInside)

        let dragPan = UIPanGestureRecognizer(target: self, action: #selector(handleDragPan(_:)))
        self._dragAreaView.addGestureRecognizer(dragPan)

        let scalePan = UIPanGestureRecognizer(target: self, action: #selector(handleScalePan(_:)))
        self._scaleAreaView.addGestureRecognizer(scalePan)
    }

    // MARK: - Actions

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
            if intersection.size.width < 50 {
                self.center.x = previousCenter.x
            }
            if intersection.size.height < 36 {
                self.center.y = previousCenter.y
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
            if newWidth < minSize.width || newWidth + self.frame.origin.x >= UIScreen.main.bounds.width {
                newWidth = self.frame.size.width
            }
            if newHeight < minSize.height || newHeight + self.frame.origin.y >= UIScreen.main.bounds.height  {
                newHeight = self.frame.size.height
            }

            self.frame.size = CGSize(width: newWidth, height: newHeight)
        }
    }

    @objc
    private func minimizeButtonClicked(_ sender: MinimizeButton) {
        minimizeAction?()
    }
    
    var isMaximized: Bool {
        return _isMaximized
    }
    private var _isMaximized = false
    private var _previousFrame = CGRect.zero

    @objc
    private func maximizeButtonClicked(_ sender: MaximizeButton) {
        _isMaximized = !_isMaximized
        if _isMaximized {
            _previousFrame = self.frame
            _dragAreaView.isUserInteractionEnabled = false
            _scaleAreaView.isUserInteractionEnabled = false
            UIView.animate(withDuration: 0.26) {
                self.frame = UIScreen.main.bounds
                self.clipsToBounds = false
            }
        } else {
            _dragAreaView.isUserInteractionEnabled = true
            _scaleAreaView.isUserInteractionEnabled = true
            UIView.animate(withDuration: 0.26) {
                self.frame = self._previousFrame
                self.clipsToBounds = true
            }
        }
    }

    // MARK: - UI Components

    private let _minimizeButton: MinimizeButton = {
        let button = MinimizeButton(frame: CGRect(x: 8, y: 8, width: 28, height: 28))
        return button
    }()

    private let _maximizeButton: MaximizeButton = {
        let button = MaximizeButton(frame: CGRect(x: 45, y: 8, width: 28, height: 28))
        return button
    }()

    private let _dragAreaView: UIView = {
        let view = UIView()
        return view
    }()

    private let _scaleAreaView: UIView = {
        let view = UIView()
        return view
    }()

    let logTextView: UITextView = {
        let view = UITextView()
        view.isEditable = false
        view.backgroundColor = UIColor.clear
        view.textColor = UIColor.white
        view.isSelectable = false
        view.layoutManager.allowsNonContiguousLayout = false
        return view
    }()
}

