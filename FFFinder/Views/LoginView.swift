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
    @State private var showPassword = false
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
    @State private var showForgot = false

    var body: some View {
        NavigationStack {
            ZStack {
                // Solid background
                Color.white
                    .ignoresSafeArea()

                VStack {
                    Spacer()
                    // Glassmorphism card
                    VStack(spacing: 28) {
                        // App Logo
                        ZStack {
                            Circle()
                                .fill(AppColors.main.opacity(0.15))
                                .frame(width: 140, height: 140)
                                .blur(radius: 0.5)
                            Image("AppLogo")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 120, height: 120)
                                .clipShape(Circle())
                        }
                        .overlay(
                            Circle()
                                .stroke(AppColors.main, lineWidth: 3)
                                .frame(width: 140, height: 140)
                        )
                        .padding(.top, 20)

                        Text("FFFinder")
                            .font(.largeTitle)
                            .fontWeight(.bold)
							.foregroundColor(AppColors.main)

                        VStack(spacing: 16) {
                            // Email field with icon
                            HStack {
                                Image(systemName: "envelope")
                                    .foregroundColor(AppColors.main)
                                TextField("Email", text: $email)
                                    .keyboardType(.emailAddress)
                                    .autocapitalization(.none)
                                    .disableAutocorrection(true)
                            }
                            .padding()
                            .background(.ultraThinMaterial)
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(AppColors.main.opacity(0.15), lineWidth: 1)
                            )

                            // Password field with icon and show/hide
                            HStack {
                                Image(systemName: "lock")
                                    .foregroundColor(AppColors.main)
                                if showPassword {
                                    TextField("Password", text: $password)
                                        .autocapitalization(.none)
                                        .disableAutocorrection(true)
                                } else {
                                    SecureField("Password", text: $password)
                                        .autocapitalization(.none)
                                        .disableAutocorrection(true)
                                }
                                Button(action: { showPassword.toggle() }) {
                                    Image(systemName: showPassword ? "eye.slash" : "eye")
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding()
                            .background(.ultraThinMaterial)
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(AppColors.main.opacity(0.15), lineWidth: 1)
                            )
                        }

                        // Forgot password and divider
                        HStack {
                            Rectangle()
                                .frame(height: 1)
								.foregroundColor(AppColors.main.opacity(0.2))
                            Text("or")
                                .font(.caption)
								.foregroundColor(AppColors.main.opacity(0.7))
                            Rectangle()
                                .frame(height: 1)
								.foregroundColor(AppColors.main.opacity(0.2))
                        }
                        .padding(.vertical, 4)

                        Button(action: { showForgot = true }) {
                            Text("Forgot password?")
                                .font(.subheadline)
                                .foregroundColor(AppColors.main)
                                .underline()
                        }
                        .sheet(isPresented: $showForgot) {
                            VStack(spacing: 24) {
                                Text("Password recovery is not implemented yet.")
                                    .font(.title3)
                                    .padding()
                                Button("Close") { showForgot = false }
                                    .padding()
                            }
                            .presentationDetents([.medium])
                        }

                        // Login button
                        Button(action: {
                            isLoggedIn = true
                        }) {
                            Text("Login")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(AppColors.main)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                                .shadow(color: AppColors.main.opacity(0.3), radius: 10, x: 0, y: 6)
                        }
                        .padding(.top, 8)
                    }
                    .padding(28)
                    .background(.ultraThinMaterial)
                    .cornerRadius(32)
                    .shadow(color: .black.opacity(0.2), radius: 24, x: 0, y: 12)
                    .padding(.horizontal, 16)
                    Spacer()
                }
            }
            .navigationDestination(isPresented: $isAuthenticated) {
                ContentView()
            }
        }
    }
}

#Preview {
    LoginView()
}
