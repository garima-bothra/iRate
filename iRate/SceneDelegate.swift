//
//  SceneDelegate.swift
//  iRate
//
//  Created by Garima Bothra on 16/06/20.
//  Copyright © 2020 Garima Bothra. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let dataController = DataController(modelName: "Rating")

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        dataController.load()
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            let controller = RatingTabBarViewController()
            controller.dataController = dataController
            controller.selectedIndex = 0
//            let navigateController = UINavigationController(rootViewController: ViewController())
//            let navigationController = controller.selectedViewController as! UINavigationController(rootViewController: ViewController())
//            let selectedController = navigationController.viewControllers[0]
//            let navigationController  = controller.selectedViewController as! UINavigationController
//             let controllers = navigationController.viewControllers // will give array
//             if controllers.count > 0 {
//                 if let viewC = controllers[0] as? ViewController {
//                    viewC.dataController = dataController
//                // do desired work
//                }
//            }
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let rootVC = storyboard.instantiateViewController(identifier: "TabBar") as? RatingTabBarViewController else {
                print("ViewController not found")
                return
            }
            rootVC.dataController = dataController
            guard let rateVC = storyboard.instantiateViewController(identifier: "rate") as? ViewController else {
                print("ViewController not found")
                return
            }
            guard let historyVC = storyboard.instantiateViewController(identifier: "historyVC") as? HistoryViewController else {
                print("ViewController not found")
                return
            }
            rateVC.dataController = dataController
            historyVC.dataController = dataController
            let navVC = UINavigationController(rootViewController: rateVC)
            let navVC2 = UINavigationController(rootViewController: historyVC)
            navVC.tabBarItem = UITabBarItem(title: "Rate", image: UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(weight: .heavy)), tag: 0)
            navVC2.tabBarItem = UITabBarItem(title: "History", image: UIImage(systemName: "line.horizontal.3", withConfiguration: UIImage.SymbolConfiguration(weight: .heavy)), tag: 1)
            rootVC.setViewControllers([navVC, navVC2], animated: true)
            //let rootNC = UINavigationController(rootViewController: rootVC)
            window.rootViewController = rootVC
       //     window.rootViewController = rootVC
            self.window = window
            window.makeKeyAndVisible()
        }
        //guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
        saveViewContext()
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
        saveViewContext()
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        saveViewContext()
    }

    func saveViewContext() {
        try? dataController.viewContext.save()
    }

}

