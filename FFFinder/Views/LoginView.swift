//
//  LoginView.swift
//  FFFinder
//
//  Created by APPLE on 2025/5/11.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isAuthenticated = false
    
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                
                // App Logo
                ZStack {
                    // Fallback solid color background
                    Circle()
                        .fill(AppColors.main)
                        .frame(width: 140, height: 140)
                    
                    // Attempt to display app logo
                    Image("AppLogo")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 136, height: 136)
                        .clipShape(Circle())
                }
                .overlay(
                    Circle()
                        .stroke(AppColors.main, lineWidth: 3)
                        .frame(width: 140, height: 140)
                )
                .padding(.top, 60)
                .padding(.bottom, 20)
				
                Text("Welcome to FFFinder")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 30)

                TextField("Email", text: $email)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)

                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)

              
                Button(action: {
                    isLoggedIn = true
                }) {
                    Text("Login")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(AppColors.main)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                Spacer()
            }
            .padding(30)
            .navigationDestination(isPresented: $isAuthenticated) {
                ContentView()
            }
        }
    }
}

#Preview {
    LoginView()
}
