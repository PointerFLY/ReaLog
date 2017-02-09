//
//  ReaLogWindow.swift
//  Example
//
//  Created by PointerFLY on 07/02/2017.
//  Copyright © 2017 PointerFLY. All rights reserved.
//

import UIKit

protocol ReaLogWindowDelegate {
    func reaLogWindowShouldAcceptTouch(window: ReaLogWindow) -> Bool
}

open class ReaLogWindow: UIWindow {

    var delegate: ReaLogWindowDelegate?

    public override init(frame: CGRect) {
        super.init(frame: frame)

        self.windowLevel = UIWindowLevelStatusBar + 100
        
        self.rootViewController = ReaLogViewController()
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
//        return (delegate != nil) ? delegate!.reaLogWindowShouldAcceptTouch(window: self) : false
        return true
    }
}
