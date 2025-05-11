//
//  ProfileView.swift
//  FFFinder
//
//  Created by ZZ on 2025.05.07.
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var notificationVM: NotificationViewModel
    
	var body: some View {
		NavigationStack {
			ZStack {
				Color("BackgroundColor")
					.edgesIgnoringSafeArea(.all)
				
				VStack(spacing: 20) {
					// Profile header
					VStack {
						Circle()
							.fill(Color.gray.opacity(0.3))
							.frame(width: 100, height: 100)
							.overlay(
								Image(systemName: "person.fill")
									.resizable()
									.scaledToFit()
									.foregroundColor(.gray)
									.padding(24)
							)
							.padding(.top, 20)
						
						Text("User Name")
							.font(.title2)
							.fontWeight(.bold)
							.padding(.top, 8)
						
						Text("Sydney, Australia")
							.foregroundColor(.secondary)
					}
					.padding(.bottom, 20)
					
					// Settings list
					VStack(spacing: 0) {
                        NavigationLink(destination: SettingsView()) {
                            SettingsRow(icon: "gear", title: "Settings")
                        }
						
                        NavigationLink(destination: NotificationView(viewModel: notificationVM)) {
                                SettingsRow(icon: "bell", title: "Notifications")
                        }
                        NavigationLink(destination: HelpSupportView()) {
                               SettingsRow(icon: "questionmark.circle", title: "Help & Support")
                        }
                        NavigationLink(destination: AboutView()) {
                            SettingsRow(icon: "info.circle", title: "About App")
                        }
					}
					.background(Color("CardBackground"))
					.cornerRadius(12)
					.padding(.horizontal)
					
					Spacer()
				}
				.padding(.top)
			}
			.navigationBarHidden(true)
		}
	}
}

#Preview {
    ProfileView(notificationVM: NotificationViewModel())
}
