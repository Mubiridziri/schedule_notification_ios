//
//  AppDelegate.swift
//  alarmX
//
//  Created by Юрий Потапов on 01.12.2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let action1 = Action(uuid: "cf68c21c-33d7-11eb-adc1-0242ac120002", name: "Yoga", dates: ["2020-12-01 17:23:00", ]);
        let action2 = Action(uuid: "1103396e-33d8-11eb-adc1-0242ac120002", name:  "Book", dates: ["2020-12-01 17:24:00"]);
        let action3 = Action(uuid: "16bdc874-33d8-11eb-adc1-0242ac120002", name: "Meditation", dates: ["2020-12-01 17:25:00"]);
        let actions : [Action] = [action1, action2, action3];
        
        for (_, action) in actions.enumerated() {
            scheduleNotification(action: action)
        }
        
        return true
    }
    
    func application(_ application: UIApplication) {
        
    }
    
    func scheduleNotification(action : Action) {
        for (_, actionDate) in action.dates.enumerated() {
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            formatter.timeZone = TimeZone.current
            if let date = formatter.date(from: actionDate) {
                let calendar = Calendar.current
                
                let notification = UNMutableNotificationContent();
                notification.categoryIdentifier = "com.mubiridziri.notifications";
                notification.sound = UNNotificationSound.default
                notification.body = "Хей! Дуй выполнять задачу - " + action.name;
                var dayComponent = DateComponents();
                dayComponent.timeZone = TimeZone.current;
                dayComponent.hour = calendar.component(.hour, from: date)
                dayComponent.minute = calendar.component(.minute, from: date)
                dayComponent.year = calendar.component(.year, from: date)
                dayComponent.month = calendar.component(.month, from: date)
                dayComponent.day = calendar.component(.day, from: date)
                
                let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: dayComponent, repeats: true);
                let dayRequest = UNNotificationRequest(identifier: action.uuid , content: notification, trigger: notificationTrigger);
                UNUserNotificationCenter.current().add(dayRequest, withCompletionHandler: {(_ error: Error?) -> Void in
                    if error == nil {
                        print("Success Notification sends.")
                    } else {
                        print("UNUserNotificationCenter Error : \(String(describing: error?.localizedDescription))")
                    }
                });
            }
        }
    }
}

