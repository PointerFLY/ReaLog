//
//  AppDelegate.swift
//  Example
//
//  Created by PointerFLY on 07/02/2017.
//  Copyright © 2017 PointerFLY. All rights reserved.
//

import UIKit
import ReaLog

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        ReaLog.shared.enable()
        ReaLog.shared.addLog("Application finished launching")
        ReaLog.shared.dateFormatter.dateFormat = "HH:mm:ss"
        ReaLog.shared.window?.floatingBallFrame = CGRect(x: 20, y: 300, width: 60, height: 60)
        ReaLog.shared.window?.logViewFrame = CGRect(x: 100, y: 100, width: 10, height: 10)
        
        let previousDate = Date();
        for _ in 0..<100 {
            let text = "Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary" +
                "interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the" +
                "background state interruptions (such as an incoming phone call or SMS message) or when tinterruptions (such as an incoming phone call or SMS" +
                "message) or when t. interruptions (such as an incoming phone call or SMS message) or when it is feasible."
            ReaLog.shared.addLog(text)
        }
        let newDate = Date();
        print(newDate.timeIntervalSince(previousDate))

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.

        ReaLog.shared.addLog("Application will resign active")
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

        ReaLog.shared.addLog("Application did enter backgroud")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.

        ReaLog.shared.addLog("Application will enter foreground")
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.

        ReaLog.shared.addLog("Application did become active")
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.

        ReaLog.shared.addLog("Application will terminate")
    }
    
    
}

