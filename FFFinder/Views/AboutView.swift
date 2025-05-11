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
                VStack(spacing: 30) {
					Spacer(minLength: 80)
                    
                    Text("About Cinephiles")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(AppColors.main)

                    Text("Version 1.0")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    Text("FFFinder is a SwiftUI-powered application designed to help users discover film festivals and award-winning films. It allows you to browse, search, and favorite festivals and films based in Sydney.")
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
