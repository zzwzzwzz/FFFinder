//
//  NotificationModel.swift
//  FFFinder
//
//  Created by APPLE on 2025/5/11.
//

import Foundation

struct NotificationItem: Identifiable {
    let id = UUID()
    let title: String
    let message: String
    let time: String
    var isRead: Bool = false
}

let systemNotifications: [NotificationItem] = [
    NotificationItem(
        title: "Version 1.0 Released",
        message: "We’re excited to announce that FFFinder v1.0 is now live! Update available from May 11, 12:00 PM.",
        time: "2025/5/11, 14:11"
    )
]
