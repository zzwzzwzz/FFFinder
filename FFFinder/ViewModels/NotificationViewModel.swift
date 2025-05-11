//
//  NotificationViewModel.swift
//  FFFinder
//
//  Created by APPLE on 2025/5/11.
//

import Foundation
import SwiftUI

class NotificationViewModel: ObservableObject {
    @Published var notifications: [NotificationItem] = []

    func addNotification(title: String, message: String) {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        let time = formatter.string(from: Date())

        let newNotification = NotificationItem(
            title: title,
            message: message,
            time: time,
            isRead: false
        )

        notifications.insert(newNotification, at: 0)
    }

    func markAsRead(_ notification: NotificationItem) {
        if let index = notifications.firstIndex(where: { $0.id == notification.id }) {
            notifications[index].isRead = true
        }
    }

    func markAllAsRead() {
        for index in notifications.indices {
            notifications[index].isRead = true
        }
    }
    
    init() {
        loadSystemNotifications()
    }
    
    func loadSystemNotifications() {
           for item in systemNotifications {
               let notification = NotificationItem(
                   title: item.title,
                   message: item.message,
                   time: item.time,
                   isRead: false
               )
               notifications.append(notification)
           }
    }
}

