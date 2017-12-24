//
//  ReaLogViewController.swift
//  Example
//
//  Created by PointerFLY on 07/02/2017.
//  Copyright © 2017 PointerFLY. All rights reserved.
//

import UIKit

class Window: UIWindow {

    public override init(frame: CGRect) {
        super.init(frame: frame)

        self.windowLevel = UIWindowLevelAlert + 100
        self.rootViewController = _viewController
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let _viewController = ViewController()

    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return _viewController.touchableArea.contains(point)
    }
}

class ViewController: UIViewController {

    var touchableArea: CGRect {
        if _ballView.isHidden == false {
            return _ballView.frame
        } else {
            return boardView.frame
        }
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(_ballView)
        self.view.addSubview(boardView)

        boardView.isHidden = true

        addEvents()
    }

    func addEvents() {
        _ballView.tapAction = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.boardView.isHidden = false
            strongSelf._ballView.isHidden = true

            let previousCenter = strongSelf.boardView.center
            strongSelf.boardView.center = strongSelf._ballView.center
            let scaleX = strongSelf._ballView.bounds.size.width / strongSelf.boardView.bounds.size.width
            let scaleY = strongSelf._ballView.bounds.size.height / strongSelf.boardView.bounds.size.height
            strongSelf.boardView.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
            strongSelf.boardView.contentView.alpha = 0.0
            strongSelf.boardView.layer.cornerRadius = 12.0 / scaleX
    
            UIView.animate(withDuration: 0.22, delay: 0.0, options: [.curveEaseInOut], animations: {
                strongSelf.boardView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                strongSelf.boardView.center = previousCenter
                strongSelf.boardView.transform = CGAffineTransform(scaleX: 1, y: 1)
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
                strongSelf.boardView.center = strongSelf._ballView.center
                let scaleX = strongSelf._ballView.bounds.size.width / strongSelf.boardView.bounds.size.width
                let scaleY = strongSelf._ballView.bounds.size.height / strongSelf.boardView.bounds.size.height
                strongSelf.boardView.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
                strongSelf.boardView.contentView.alpha = 0.0
                strongSelf.boardView.layer.cornerRadius = 12.0 / scaleX
            }, completion: { _ in
                strongSelf.boardView.isHidden = true
                strongSelf._ballView.isHidden = false
                strongSelf.boardView.center = previousCenter
            })
        }
    }

    private let _ballView = FloatingBallView()
    let boardView = BoardView()
}
