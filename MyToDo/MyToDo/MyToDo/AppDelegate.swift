//
//  AppDelegate.swift
//  MyToDo
//
//  Created by Chiwon Song on 2020/07/25.
//  Copyright © 2020 Chiwon Song. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if #available(iOS 13, *) {
            // SceneDeledate

        } else {
            let reposity: Repository = MemoryRepository()
            let service: ToDoService = ToDoServiceImpl(repository: reposity)

            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let navi = storyboard.instantiateInitialViewController() as? UINavigationController
            let viewController = navi?.viewControllers.first as? ViewController
            viewController?.service = service

            window = UIWindow(frame: UIScreen.main.bounds)
            window?.rootViewController = navi
            window?.makeKeyAndVisible()
        }

        return true
    }
}
