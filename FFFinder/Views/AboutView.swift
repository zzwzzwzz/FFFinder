//
//  AboutView.swift
//  FFFinder
//
//  Created by APPLE on 2025/5/11.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        ZStack {
            AppColors.background
                .edgesIgnoringSafeArea(.all)

            ScrollView {
                VStack(spacing: 24) {
                    Spacer()
                    
                    Text("About Cinephiles")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(AppColors.main)

                    Text("Version 1.0")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    Text("Cinephiles is a SwiftUI-powered application designed to help users discover film festivals and award-winning films. It allows you to browse, search, and favorite festivals and films from around the world.")
                        .font(.body)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Image("simplePic")
                        .resizable()
                        .scaledToFit()
                        .opacity(0.8)
                        .frame(width: 100)
                        .padding(.top, 8)
                        .padding(.bottom, 20)
                    
                    Text("Developed by Team Cinephiles.")
                        .font(.footnote)
                        .foregroundColor(AppColors.main)
                    
                    Spacer()
                }
                .padding()
            }
        }
    }
}

#Preview {
    NavigationStack {
        AboutView()
    }
}
