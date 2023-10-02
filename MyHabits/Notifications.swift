//
//  Notifications.swift
//  MyHabits
//
//  Created by Эля Корельская on 02.10.2023.
//

import UserNotifications

class LocalNotificationsService {
    func registerForLatestUpdatesIfPossible(habit: Habit) {
        /// запрос на отображение уведомлений - звук / алерт
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            /// если разрешил - отображать
            if granted {
                self.scheduleNotification(for: habit)
            } else {
                print("Уведомления не разрешены.")
            }
        }
    }
    
    func scheduleNotification(for habit: Habit) {
        let content = UNMutableNotificationContent()
        content.title = "Напоминание о привычке"
        content.body = "Пора заняться привычкой: \(habit.name)"
        content.sound = UNNotificationSound.default
        content.badge = 1
        

        var dateComponents = DateComponents()
        dateComponents.hour = Calendar.current.component(.hour, from: habit.date)
        dateComponents.minute = Calendar.current.component(.minute, from: habit.date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: habit.id, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Ошибка при добавлении уведомления для привычки: \(error.localizedDescription)")
            } else {
                print("Уведомление для привычки успешно добавлено.")
                print("\(habit.id), \(habit.date)")
            }
        }
    }

}

