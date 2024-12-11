//
//  AppDelegate.swift
//  CoreStructure_iOS
//
//  Created by Rath! on 12/8/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        handleNavigationbarTitle()
        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        print("configurationForConnecting")
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        print("didDiscardSceneSessions")
    }
}

func handleNavigationbarTitle(){
    
    //MARK: - Handle title navigationBar
    let font = UIFont.systemFont(ofSize: 18, weight: .medium)
    
    let titleAttribute = [
        NSAttributedString.Key.font: font,
        NSAttributedString.Key.foregroundColor: UIColor.white
    ]
    
    UINavigationBarAppearance().titleTextAttributes = titleAttribute as [NSAttributedString.Key : Any]
}
