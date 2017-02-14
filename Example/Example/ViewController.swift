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

    @IBOutlet weak var _emptyView: UIView!
    private let _webView = WKWebView()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(_webView)

        let url = URL(string: "https://aliexpress.com")!
        var request = URLRequest(url: url)
        request.timeoutInterval = 5.0
        _webView.load(request)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        _webView.frame = _emptyView.frame
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        ReaLog.shared.addLog("WebView did finish")
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        ReaLog.shared.addLog("failed to load")
    }
}

