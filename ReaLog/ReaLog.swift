//
//  ReaLog.swift
//  ReaLog
//
//  Created by PointerFLY on 07/02/2017.
//  Copyright © 2017 PointerFLY. All rights reserved.
//

import UIKit


open class ReaLog {

    open static let shared = ReaLog()

    open var isAutoAddLineFeed = true

    public init() {

    }

    open func enable() {
        _window = Window(frame: UIScreen.main.bounds)
        _window?.isHidden = false
    }

    open func disable() {
        _window = nil
    }

    open var logLength: Int {
        return BoardView.shared.textView.text.characters.count
    }

    open func addLog(_ log: String) {
        let textView = BoardView.shared.textView
        textView.text.append(log + (isAutoAddLineFeed ? "\n" : ""))
        textView.scrollRangeToVisible(NSRange(location: textView.text.characters.count, length: 1))
    }

    private var _window: Window?
}
