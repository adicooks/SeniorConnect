import UserNotifications

class NotificationManager {
    static func scheduleHelloNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Hello"
        content.body = "Time to say Hello!"
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 6000, repeats: true)
        
        let request = UNNotificationRequest(identifier: "helloNotification", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled successfully")
            }
        }
    }
}

