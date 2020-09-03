//
//  AppDelegate.swift
//  FStore
//
//  Created by Nguyễn Hải Âu on 2/21/20.
//  Copyright © 2020 Nguyễn Hải Âu. All rights reserved.
//

import UIKit
import SDWebImage
import FBSDKCoreKit
import GoogleSignIn
import Stripe

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        window?.makeKeyAndVisible()
        window?.rootViewController = TabBarController()
        
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barStyle = .blackOpaque
        
        
        // Facebook
        ApplicationDelegate.shared.application( application, didFinishLaunchingWithOptions: launchOptions )
        
        // Google SignIn
        GIDSignIn.sharedInstance()?.clientID = "729127978103-035dnvan5s5905i1eu7hh77137tqu9d0.apps.googleusercontent.com"
        
        Stripe.setDefaultPublishableKey("pk_test_eG5gHuMm84YHihm8rDLkNCC800CHiPJY9k")
        
        
        return true
    }
    
    func application( _ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:] ) -> Bool {
        
        // Facebook
        let appId: String = Settings.appID!
        if url.scheme != nil && url.scheme!.hasPrefix("fb\(appId)") && url.host ==  "authorize" {
            return ApplicationDelegate.shared.application(app, open: url, options: options)
        }
        
        // Google
        if let sourceApplication = options[.sourceApplication] as? String, let annotation = options[.annotation] {
            return GIDSignIn.sharedInstance()?.handle(url, sourceApplication: sourceApplication, annotation: annotation) ?? false
        }
        
        return true
        
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        AppEvents.activateApp()
    }
}

