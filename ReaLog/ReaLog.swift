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
    
    open var lineFeed = "\n"
    
    open var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss.SSS  "
        return formatter
    }()
    
    /// If needed, you can create multiple ReaLog window.
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
        return _boardView.logTextView.text.count
    }

    open func addLog(_ log: String) {
        let dateString = dateFormatter.string(from: Date())
        
        let textView = _boardView.logTextView
        textView.text.append(dateString + log + lineFeed)
        textView.scrollRangeToVisible(NSRange(location: textView.text.count, length: 1))
    }

    private var _window: Window?
    private var _boardView: BoardView {
        return (_window?.rootViewController as! ViewController).boardView
    }
}
