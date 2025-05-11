//
//  SettingsView.swift
//  FFFinder
//
//  Created by APPLE on 2025/5/11.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = true
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Settings")
                        .font(.largeTitle.bold())
                        .foregroundColor(.main)
                    Text("Customize your Cinephiles experience")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                
                VStack(alignment: .leading, spacing: 6) {
                    Text("Username (coming soon)")
                        .font(.headline)
                    Text("This will be editable after login is implemented.")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .padding(.horizontal)
                
                Section {
                    Button(role: .destructive) {
                        isLoggedIn = false
                    } label: {
                        Label("Log Out", systemImage: "arrow.backward.square")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.main)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .padding(.horizontal)
                    }
                }
                .padding(.top)
            }
            .background(AppColors.background)
        }
    }
}

#Preview {
    SettingsView()
}
