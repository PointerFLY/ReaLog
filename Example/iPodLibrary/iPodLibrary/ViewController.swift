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

        NotificationCenter.default.addObserver(self, selector: #selector(handleMediaLibraryDidChange(_:)), name: NSNotification.Name.MPMediaLibraryDidChange, object: nil)
    }

    func rightItemClicked(_ sender: UIBarButtonItem) {
        _player?.pause()
        _player = nil
        self.title = "Home"
    }

    func handleMediaLibraryDidChange(_ notification: Notification) {
        print("changed")
        print(notification.userInfo!)
    }

    @IBAction func pickMusicButtonClicked(_ sender: UIButton) {
        let picker = MPMediaPickerController(mediaTypes: .any)
        picker.prompt = "使用MPMediaPickerController选取音乐"
        picker.allowsPickingMultipleItems = true
        picker.delegate = self
        picker.showsCloudItems = true
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
        try! AVAudioSession.sharedInstance().setActive(true)
        mediaPicker.dismiss(animated: true, completion: nil)
        if let item = mediaItemCollection.items.first {
            if item.hasProtectedAsset == true || item.value(forKey: MPMediaItemPropertyIsCloudItem) as! Bool == true {
                self.title = item.title
                try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
                MPMusicPlayerController.applicationMusicPlayer().setQueue(with: mediaItemCollection)
                MPMusicPlayerController.applicationMusicPlayer().play()

                return
            }


            let url = item.value(forProperty: MPMediaItemPropertyAssetURL) as! URL
            print(url)
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
                    self.title = item.title
                    try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
                
                    self._player = AVPlayer(url: toUrl)
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
    
    private var _player: AVPlayer? = nil
}

