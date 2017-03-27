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

    open var dateFormat: String? = "HH:mm:ss.SSS"

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
        return _boardView.logTextView.text.characters.count
    }

    open func addLog(_ log: String) {
        let textView = _boardView.logTextView

        let lineFeed = isAutoAddLineFeed ? "\n" : ""

        var dateString: String = ""
        if let format = dateFormat {
            let formatter = DateFormatter()
            formatter.dateFormat = format
            dateString = formatter.string(from: Date())
            dateString  += "  "
        }

        textView.text.append(dateString + log + lineFeed)
        textView.scrollRangeToVisible(NSRange(location: textView.text.characters.count, length: 1))
    }

    private var _window: Window?
    private var _boardView: BoardView {
        return (_window?.rootViewController as! ViewController).boardView
    }
}
