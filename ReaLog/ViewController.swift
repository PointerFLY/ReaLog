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
            return CGRect.zero
        }
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(_ballView)

        addEvents()
    }

    func addEvents() {
        _ballView.tapAction = { [weak self] in
            guard let strongSelf = self else { return }
//            strongSelf._ballView.isHidden = true
        }
    }
    
    private let _ballView = FloatingBallView()
    private let _logView = LogView()
}
