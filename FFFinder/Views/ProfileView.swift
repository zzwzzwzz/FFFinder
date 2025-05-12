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
				Color.white.ignoresSafeArea()
				VStack(spacing: 24) {
					// Profile card
					VStack(spacing: 16) {
						Image("profile")
							.resizable()
							.scaledToFill()
							.frame(width: 100, height: 100)
							.clipShape(Circle())
							.overlay(
								Circle()
									.stroke(AppColors.main, lineWidth: 3)
							)
							.shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 4)
							.padding(.top, 24)
						
						Text("User Name")
							.font(.title2)
							.fontWeight(.bold)
							.foregroundColor(AppColors.main)
						
						Text("Sydney, Australia")
							.foregroundColor(.secondary)
					}
					.frame(maxWidth: .infinity)
					.padding(.vertical, 24)
					.cornerRadius(20)
					.padding(.horizontal)
					
					// Settings list card
					VStack(spacing: 8) {
						NavigationLink(destination: SettingsView()) {
							SettingsRow(icon: "gear", title: "Settings")
						}
						
						Divider()
						
						NavigationLink(destination: NotificationView(viewModel: notificationVM)) {
							SettingsRow(icon: "bell", title: "Notifications")
						}
						
						Divider()
						
						NavigationLink(destination: HelpSupportView()) {
							SettingsRow(icon: "questionmark.circle", title: "Help & Support")
						}
						
						Divider()
						
						NavigationLink(destination: AboutView()) {
							SettingsRow(icon: "info.circle", title: "About App")
						}
					}
					.background(Color(.white))
					.cornerRadius(16)
					.shadow(color: .black.opacity(0.04), radius: 8, x: 0, y: 2)
					.padding(.horizontal)
					
					Spacer()
					Text("© 2025 FFFinder. All rights reserved.")
						.font(.footnote)
						.foregroundColor(.secondary)
						.frame(maxWidth: .infinity)
						.padding(.bottom, 12)
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
