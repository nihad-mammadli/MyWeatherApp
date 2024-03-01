//
//  SceneDelegate.swift
//  MyWeather
//
//  Created by Nebula on 18.02.24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
            let navigationController = UINavigationController(rootViewController: Home())
            
        
            guard let windowScene = (scene as? UIWindowScene) else { return }
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = navigationController
            self.window = window
            self.window?.makeKeyAndVisible()
        }
}

