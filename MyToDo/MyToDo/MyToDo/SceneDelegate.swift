//
//  SceneDelegate.swift
//  MyToDo
//
//  Created by Chiwon Song on 2020/07/25.
//  Copyright © 2020 Chiwon Song. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let reposity: Repository = MemoryRepository()
        let service: ToDoService = ToDoServiceImpl(repository: reposity)

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navi = storyboard.instantiateInitialViewController() as? UINavigationController
        let viewController = navi?.viewControllers.first as? ViewController
        viewController?.service = service

        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navi
        window?.makeKeyAndVisible()
    }
}
