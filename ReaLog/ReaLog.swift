//
//  ReaLog.swift
//  ReaLog
//
//  Created by PointerFLY on 07/02/2017.
//  Copyright © 2017 PointerFLY. All rights reserved.
//

import UIKit

open class ReaLog {

    public init() {
        
    }

    open func enable() {
        _window = Window(frame: UIScreen.main.bounds)
        _window?.isHidden = false
    }

    open func disable() {
        _window = nil
    }

    var _window: Window?
}
