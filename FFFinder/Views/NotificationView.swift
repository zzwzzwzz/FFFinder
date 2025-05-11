//
//  NotificationView.swift
//  FFFinder
//
//  Created by APPLE on 2025/5/11.
//

import SwiftUI

struct NotificationView: View {
    @ObservedObject var viewModel: NotificationViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text("Notifications")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(AppColors.main)
                    
                    Spacer()
                    
                    Button(action: {
                        viewModel.markAllAsRead()
                    }) {
                        Text("Mark All as Read")
                            .font(.subheadline)
                            .foregroundColor(AppColors.main)
                    }
                }
                .padding(.horizontal)

                // 通知列表
                ForEach(viewModel.notifications) { notification in
                    Button(action: {
                        viewModel.markAsRead(notification)
                    }) {
                        HStack(alignment: .top, spacing: 12) {
                            if !notification.isRead {
                                Circle()
                                    .fill(Color.red)
                                    .frame(width: 10, height: 10)
                                    .padding(.top, 6)
                            } else {
                                Circle()
                                    .fill(Color.clear)
                                    .frame(width: 10, height: 10)
                                    .padding(.top, 6)
                            }

                            VStack(alignment: .leading, spacing: 6) {
                                Text(notification.title)
                                    .font(.headline)
                                    .foregroundColor(notification.isRead ? .secondary : .primary)
                                
                                Text(notification.message)
                                    .font(.body)
                                    .foregroundColor(notification.isRead ? .gray : .secondary)
                                
                                Text(notification.time)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                        }
                        .padding()
                        .background(Color("CardBackground"))
                        .cornerRadius(12)
                        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
                        .padding(.horizontal)
                    }
                }

                Spacer(minLength: 20)
            }
            .padding(.top)
        }
        .background(AppColors.background)
    }
}

#Preview {
    NotificationView(viewModel: NotificationViewModel())
}
