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

        self.windowLevel = UIWindowLevelStatusBar + 100
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
            return _boardView.frame
        }
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(_ballView)
        self.view.addSubview(_boardView)

        _boardView.isHidden = true

        addEvents()
    }

    func addEvents() {
        _ballView.tapAction = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf._ballView.isHidden = true
            strongSelf._boardView.isHidden = false
        }
        _boardView.minimizeAction = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf._boardView.isHidden = true
            strongSelf._ballView.isHidden = false
        }
    }
    
    private let _ballView = FloatingBallView()
    private let _boardView = BoardView()
}
