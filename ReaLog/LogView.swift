//
//  LogView.swift
//  ReaLog
//
//  Created by PointerFLY on 09/02/2017.
//  Copyright © 2017 PointerFLY. All rights reserved.
//

import UIKit

class LogView: UIVisualEffectView {

    var minimizeAction: (() -> Void)?

    init() {
        super.init(effect: UIBlurEffect(style: .dark))
        self.isUserInteractionEnabled = true

        self.frame = CGRect(x: 20, y: 160, width: 260, height: 260)
        self.layer.cornerRadius = 12.0
        self.clipsToBounds = true

        self.addSubview(_minimizeButton)
        self.addSubview(_maximizeButton)

        _minimizeButton.addTarget(self, action: #selector(minimizeButtonClicked(_:)), for: .touchUpInside)
        _maximizeButton.addTarget(self, action: #selector(maximizeButtonClicked(_:)), for: .touchUpInside)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc
    private func minimizeButtonClicked(_ sender: MinimizeButton) {
        minimizeAction?()
    }

    @objc
    private func maximizeButtonClicked(_ sender: MaximizeButton) {
        self.frame = UIScreen.main.bounds
    }

    private let _minimizeButton: MinimizeButton = {
        let button = MinimizeButton(frame: CGRect(x: 8, y: 8, width: 28, height: 28))
        return button
    }()

    private let _maximizeButton: MaximizeButton = {
        let button = MaximizeButton(frame: CGRect(x: 45, y: 8, width: 28, height: 28))
        return button
    }()
}

