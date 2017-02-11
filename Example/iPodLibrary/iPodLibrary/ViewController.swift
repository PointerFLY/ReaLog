//
//  ViewController.swift
//  iPodLibrary
//
//  Created by PointerFLY on 10/02/2017.
//  Copyright © 2017 PointerFLY. All rights reserved.
//

import UIKit
import MediaPlayer

class ViewController: UIViewController, MPMediaPickerControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        let rightBarButtonItem = UIBarButtonItem(title: "停止", style: .plain, target: self, action: #selector(rightItemClicked(_:)))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }

    func rightItemClicked(_ sender: UIBarButtonItem) {
        _player?.stop()
        _player = nil
        self.title = "Home"
    }

    @IBAction func pickMusicButtonClicked(_ sender: UIButton) {
        let picker = MPMediaPickerController(mediaTypes: .any)
        picker.prompt = "使用MPMediaPickerController选取音乐"
        picker.allowsPickingMultipleItems = true
        picker.delegate = self
        picker.showsCloudItems = false
        self.present(picker, animated: true, completion: nil)
    }

    @IBAction func queryMusicButtonClicked(_ sender: UIButton) {
//        let query = MPMediaQuery(filterPredicates: nil)
//        let items = query.items


    }

    // MARK: - MPMediaPickerControllerDelegate

    func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController) {
        mediaPicker.dismiss(animated: true, completion: nil)
    }

    func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        mediaPicker.dismiss(animated: true, completion: nil)

        if let item = mediaItemCollection.items.first {
            let url = item.value(forProperty: MPMediaItemPropertyAssetURL) as! URL
            let asset = AVURLAsset(url: url)
            let exporter = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetAppleM4A)
            exporter?.outputFileType = "com.apple.m4a-audio"


            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
            let docUrl = URL(fileURLWithPath: path!)
            let toUrl = docUrl.appendingPathComponent("\(item.albumTitle).m4a")

            if FileManager.default.fileExists(atPath: toUrl.path) {
                try! FileManager.default.removeItem(at: toUrl)
            }

            exporter?.outputURL = toUrl
            exporter?.exportAsynchronously(completionHandler: {
                switch exporter!.status {
                case AVAssetExportSessionStatus.completed:
                    print("complete")
                    self.title = item.albumTitle
                    self._player = try! AVAudioPlayer(contentsOf: toUrl)
                    self._player?.play()

                case AVAssetExportSessionStatus.failed:
                    print("failed with:")
                    print(exporter!.error!)
                default:
                    print("default")
                }
            })
        }
    }

    private var _player: AVAudioPlayer? = nil
}

