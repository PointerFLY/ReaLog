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

class HomeViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var _emptyView: UIView!
    private let _webView = WKWebView()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(_webView)

        _webView.navigationDelegate = self
        loadWebsite(url: _aliexpURL)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        ReaLog.shared.addLog("HomeViewController appeared")
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        _webView.frame = _emptyView.frame
    }

    @IBAction func aliExpButtonClicked(_ sender: UIButton) {
        loadWebsite(url: _aliexpURL)
    }

    @IBAction func gitHubButtonClicked(_ sender: UIButton) {
        loadWebsite(url: _githubURL)
    }

    @IBAction func refreshButtonClicked(_ sender: UIButton) {
        _webView.reload()
        ReaLog.shared.addLog("WebView is reloading")
    }

    @IBAction func forwardButtonClicked(_ sender: UIButton) {
        _webView.goForward()
        ReaLog.shared.addLog("WebView is going forward")
    }

    @IBAction func backExpButtonClicked(_ sender: UIButton) {
        _webView.goBack()
        ReaLog.shared.addLog("WebView is going back")
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        ReaLog.shared.addLog("\(webView.url!.absoluteString) finished loading")
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        ReaLog.shared.addLog("\(webView.url!.absoluteString) failed loading with error: \(error.localizedDescription)")
    }

    private func loadWebsite(url: URL) {
        var request = URLRequest(url: url)
        request.timeoutInterval = 10.0
        _webView.load(request)
    }

    private let _aliexpURL = URL(string: "https://aliexpress.com")!
    private let _githubURL = URL(string: "https://github.com")!
}

