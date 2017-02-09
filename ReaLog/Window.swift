//
//  ReaLogWindow.swift
//  Example
//
//  Created by PointerFLY on 07/02/2017.
//  Copyright © 2017 PointerFLY. All rights reserved.
//

import UIKit

protocol WindowDelegate {
    func windowShouldAcceptTouch(window: Window) -> Bool
}

open class Window: UIWindow {

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
