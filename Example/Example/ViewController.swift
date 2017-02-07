//
//  ViewController.swift
//  Example
//
//  Created by PointerFLY on 07/02/2017.
//  Copyright © 2017 PointerFLY. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        _webView.frame = self.view.frame

        self.view.addSubview(_webView)
    }

    private var _webView: WKWebView = {
        let view = WKWebView()
        let url = URL(string: "https://github.com")
        let request = URLRequest(url: url!)
        view.load(request)
        return view
    }()
}

