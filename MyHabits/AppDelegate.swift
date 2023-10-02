//
//  AppDelegate.swift
//  MyHabits
//
//  Created by Эля Корельская on 29.10.2022.
//

import UIKit
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // увеличить врамя показа Launch Screen
        Thread.sleep(forTimeInterval: 3.0)
        let habit = Habit(name: "Example Habit", date: Date(), color: .blue, id: UUID().uuidString)
        let localNotificationsService = LocalNotificationsService()
        localNotificationsService.registerForLatestUpdatesIfPossible(habit: habit)
        UNUserNotificationCenter.current().delegate = self
        return true
    }

    // MARK: -  UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

}
/// чтобы привычка отображалась не только в фоновом режиме, но и в активном
extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping
    (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert,.sound])
        print(#function)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print(#function)
    }
    
}

