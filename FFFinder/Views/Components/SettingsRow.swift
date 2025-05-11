//
//  SettingsRow.swift
//  FFFinder
//
//  Created by ZZ on 2025.05.07.
//

import SwiftUI

struct SettingsRow: View {
	let icon: String
	let title: String
	
	var body: some View {
			HStack {
				Image(systemName: icon)
					.frame(width: 24, height: 24)
					.foregroundColor(AppColors.main)
				
				Text(title)
					.foregroundColor(.primary)
				
				Spacer()
				
				Image(systemName: "chevron.right")
					.foregroundColor(.gray)
					.font(.system(size: 14, weight: .semibold))
			}
			.padding(.vertical, 14)
			.padding(.horizontal)
	}
}

#Preview {
	VStack(spacing: 0) {
		SettingsRow(icon: "gear", title: "Settings")
		SettingsRow(icon: "bell", title: "Notifications")
	}
	.background(Color("CardBackground"))
	.cornerRadius(12)
	.padding()
}
