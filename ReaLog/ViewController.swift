//
//  ReaLogViewController.swift
//  Example
//
//  Created by PointerFLY on 07/02/2017.
//  Copyright © 2017 PointerFLY. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var touchableArea: CGRect {
        if _ballView.isHidden == false {
            return _ballView.frame
        } else {
            return _logView.frame
        }
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(_ballView)
        self.view.addSubview(_logView)

        _logView.isHidden = true

        addEvents()
    }

    func addEvents() {
        _ballView.tapAction = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf._ballView.isHidden = true
            strongSelf._logView.isHidden = false
        }
        _logView.minimizeAction = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf._logView.isHidden = true
            strongSelf._ballView.isHidden = false
        }
    }
    
    private let _ballView = FloatingBallView()
    private let _logView = LogView()
}
