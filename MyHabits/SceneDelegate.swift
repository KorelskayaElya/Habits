//
//  SceneDelegate.swift
//  MyHabits
//
//  Created by Эля Корельская on 29.10.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        if #available(iOS 16.0, *) {
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            windowScene?.requestGeometryUpdate(.iOS(interfaceOrientations: .portrait))
        }
        self.window = UIWindow(windowScene: windowScene)
        //1 навигационный контроллер
        let navController = UINavigationController(rootViewController: InfoViewController())
        //2 навигационный контроллер
        let secondItemController = UINavigationController(rootViewController: HabitsViewController())
        UINavigationBar.appearance().backgroundColor = UIColor(named: "White")
        //создание панели вкладок
        let tabBarController = UITabBarController()
        
        tabBarController.viewControllers = [
            secondItemController, navController
        ]
        
        tabBarController.viewControllers?.enumerated().forEach {
            UITabBar.appearance().backgroundColor = .white
            UITabBar.appearance().tintColor = UIColor(named: "Purple")
            UITabBar.appearance().unselectedItemTintColor = .systemGray
            $1.tabBarItem.title = $0 == 0 ? "Привычки" : "Информация"
            $1.tabBarItem.image = $0 == 0
            ? UIImage(systemName: "rectangle.grid.1x2.fill")
            : UIImage(systemName: "info.circle.fill")
           
        }

        self.window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

