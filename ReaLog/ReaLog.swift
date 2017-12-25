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
    
    /// If needed, you can create multiple ReaLog window.
    public init() {
        
    }
    
    open var lineFeed = "\n"
    
    open var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss.SSS  "
        return formatter
    }()
    
    open private(set) var window: Window?

    open func enable() {
        window = Window(frame: UIScreen.main.bounds)
        window?.isHidden = false
    }

    open func disable() {
        window = nil
    }

    open var logLength: Int {
        return _boardView.logTextView.text.count
    }

    open func addLog(_ log: String) {
        let dateString = dateFormatter.string(from: Date())
        let logString = dateString + log + lineFeed
        
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            let textView = strongSelf._boardView.logTextView
            textView.text.append(logString)
            textView.scrollRangeToVisible(NSRange(location: textView.text.count, length: 1))
        }
    }

    private var _boardView: BoardView {
        return (window?.rootViewController as! ViewController).boardView
    }
}
