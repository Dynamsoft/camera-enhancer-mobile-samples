//
//  AppDelegate.swift
//  HelloWorldSwift
//
//  Copyright © Dynamsoft. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // The string "DLS2eyJvcmdhbml6YXRpb25JRCI6IjIwMDAwMSJ9" here will grant you a time-limited public trial license. After that, please visit: https://www.dynamsoft.com/customer/license/trialLicense?product=dce&utm_source=installer&package=ios to request for an extension.
        DynamsoftCameraEnhancer.initLicense("DLS2eyJvcmdhbml6YXRpb25JRCI6IjIwMDAwMSJ9", verificationDelegate: self)
        // Override point for customization after application launch.
        return true
    }
}

