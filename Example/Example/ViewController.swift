//
//  ViewController.swift
//  Example
//
//  Created by PointerFLY on 07/02/2017.
//  Copyright © 2017 PointerFLY. All rights reserved.
//

import UIKit
import WebKit
import ReaLog

class ViewController: UIViewController, WKNavigationDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        _webView.frame = self.view.frame

        self.view.addSubview(_webView)

        ReaLog.shared.addLog("sdff")
    }

    private var _webView: WKWebView = {
        let view = WKWebView()
        let url = URL(string: "https://m.taobao.com")
        let request = URLRequest(url: url!)
        view.load(request)
        return view
    }()

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {

    }
}

