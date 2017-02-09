//
//  ReaLogViewController.swift
//  Example
//
//  Created by PointerFLY on 07/02/2017.
//  Copyright © 2017 PointerFLY. All rights reserved.
//

import UIKit

class ReaLogViewController: UIViewController {

    public override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(logView)
    }

    let logView = FloatingBallView()
}
