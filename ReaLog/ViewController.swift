//
//  ReaLogViewController.swift
//  Example
//
//  Created by PointerFLY on 07/02/2017.
//  Copyright © 2017 PointerFLY. All rights reserved.
//

import UIKit

open class Window: UIWindow {

    public override init(frame: CGRect) {
        super.init(frame: frame)

        self.windowLevel = UIWindowLevelAlert + 100
        self.rootViewController = _viewController
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open var floatingBallFrame: CGRect {
        get {
            return _viewController.ballView.frame
        }
        set {
            _viewController.ballView.frame = newValue
        }
    }
    
    open var logViewFrame: CGRect {
        get {
            return _viewController.boardView.frame
        }
        set {
            let newWidth = max(newValue.size.width, _viewController.boardView.minSize.width)
            let newHeight = max(newValue.size.height, _viewController.boardView.minSize.height)
            _viewController.boardView.frame = CGRect(origin: newValue.origin, size: CGSize(width: newWidth, height: newHeight))
        }
    }

    private let _viewController = ViewController()

    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return _viewController.touchableArea.contains(point)
    }
}

class ViewController: UIViewController {

    var touchableArea: CGRect {
        if ballView.isHidden == false {
            return ballView.frame
        } else {
            return boardView.frame
        }
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(ballView)
        self.view.addSubview(boardView)

        boardView.isHidden = true

        addEvents()
    }

    private func addEvents() {
        ballView.tapAction = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.boardView.isHidden = false
            strongSelf.ballView.isHidden = true

            let previousCenter = strongSelf.boardView.center
            strongSelf.boardView.center = strongSelf.ballView.center
            let scaleX = strongSelf.ballView.bounds.size.width / strongSelf.boardView.bounds.size.width
            let scaleY = strongSelf.ballView.bounds.size.height / strongSelf.boardView.bounds.size.height
            strongSelf.boardView.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
            strongSelf.boardView.contentView.alpha = 0.0
            strongSelf.boardView.layer.cornerRadius = 12.0 / scaleX
    
            UIView.animate(withDuration: 0.22, delay: 0.0, options: [.curveEaseInOut], animations: {
                strongSelf.boardView.center = previousCenter
                strongSelf.boardView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                strongSelf.boardView.contentView.alpha = 1.0
                strongSelf.boardView.layer.cornerRadius = 12.0
            }, completion: nil)
        }
        boardView.minimizeAction = { [weak self] in
            guard let strongSelf = self else { return }

            let previousCenter = strongSelf.boardView.center
            strongSelf.boardView.contentView.alpha = 1.0
            strongSelf.boardView.layer.cornerRadius = 12.0
            
            UIView.animate(withDuration: 0.28, delay: 0.0, options: [.curveEaseInOut], animations: {
                strongSelf.boardView.center = strongSelf.ballView.center
                let scaleX = strongSelf.ballView.bounds.size.width / strongSelf.boardView.bounds.size.width
                let scaleY = strongSelf.ballView.bounds.size.height / strongSelf.boardView.bounds.size.height
                strongSelf.boardView.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
                strongSelf.boardView.contentView.alpha = 0.0
                strongSelf.boardView.layer.cornerRadius = 12.0 / scaleX
            }, completion: { _ in
                strongSelf.boardView.isHidden = true
                strongSelf.ballView.isHidden = false
                strongSelf.boardView.center = previousCenter
                strongSelf.boardView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            })
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleDeviceOrientationChanged(notification:)), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    private var _orientation: UIInterfaceOrientation?
    
    private func isDistinctOrientation(left: UIInterfaceOrientation, right: UIInterfaceOrientation) -> Bool {
        let potraits: [UIInterfaceOrientation] = [.portrait, .portraitUpsideDown, .unknown]
        return potraits.contains(left) != potraits.contains(right)
    }
    
    @objc
    private func handleDeviceOrientationChanged(notification: Notification) {
        let orientation = UIApplication.shared.statusBarOrientation
        guard _orientation != nil else {
            _orientation = orientation
            return
        }
        guard isDistinctOrientation(left: _orientation!, right: orientation) else {
            _orientation = orientation
            return
        }
        _orientation = orientation
    
        switch orientation {
        case .portrait, .portraitUpsideDown, .unknown:
            let scaleBig = UIScreen.main.bounds.height / UIScreen.main.bounds.width
            let scaleSmall = (1.0 / scaleBig)
            ballView.frame.origin.x = scaleSmall * ballView.frame.origin.x
            ballView.frame.origin.y = scaleBig * ballView.frame.origin.y
            if boardView.isMaximized {
                boardView.frame = self.view.frame
            } else {
                boardView.frame.origin.x = scaleSmall * boardView.frame.origin.x
                boardView.frame.origin.y = scaleBig * boardView.frame.origin.y
            }
        case .landscapeLeft, .landscapeRight:
            let scaleSmall = UIScreen.main.bounds.height / UIScreen.main.bounds.width
            let scaleBig = (1.0 / scaleSmall)
            ballView.frame.origin.x = scaleBig * ballView.frame.origin.x
            ballView.frame.origin.y = scaleSmall * ballView.frame.origin.y
            if boardView.isMaximized {
                boardView.frame = self.view.frame
            } else {
                boardView.frame.origin.x = scaleBig * boardView.frame.origin.x
                boardView.frame.origin.y = scaleSmall * boardView.frame.origin.y
            }
        }
    }

    let ballView = FloatingBallView()
    let boardView = BoardView()
}
