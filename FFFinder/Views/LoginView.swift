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
    @State private var emailError: String? = nil
    @State private var passwordError: String? = nil
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    // Validation functions
    private func validateEmail() -> Bool {
        let emailRegex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        let isValid = emailPredicate.evaluate(with: email)
        
        if email.isEmpty {
            emailError = "Email cannot be empty"
        } else if !isValid {
            emailError = "Please enter a valid email"
        } else {
            emailError = nil
        }
        
        return isValid && !email.isEmpty
    }
    
    private func validatePassword() -> Bool {
        if password.isEmpty {
            passwordError = "Password cannot be empty"
            return false
        } else if password.count < 6 {
            passwordError = "Password must be at least 6 characters"
            return false
        } else {
            passwordError = nil
            return true
        }
    }
    
    private func validateForm() -> Bool {
        let isEmailValid = validateEmail()
        let isPasswordValid = validatePassword()
        return isEmailValid && isPasswordValid
    }

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
                            // Email field with icon and error message
                            VStack(alignment: .leading, spacing: 4) {
                                HStack {
                                    Image(systemName: "envelope")
                                        .foregroundColor(AppColors.main)
                                    TextField("Email", text: $email)
                                        .keyboardType(.emailAddress)
                                        .autocapitalization(.none)
                                        .disableAutocorrection(true)
                                        .onChange(of: email) { oldValue, newValue in
                                            if !email.isEmpty {
                                                _ = validateEmail()
                                            } else {
                                                emailError = nil
                                            }
                                        }
                                }
                                .padding()
                                .background(.ultraThinMaterial)
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(emailError == nil ? AppColors.main.opacity(0.15) : Color.red, lineWidth: 1)
                                )
                                
                                if let error = emailError {
                                    Text(error)
                                        .font(.caption)
                                        .foregroundColor(.red)
                                        .padding(.horizontal, 8)
                                }
                            }

                            // Password field with icon, show/hide, and error message
                            VStack(alignment: .leading, spacing: 4) {
                                HStack {
                                    Image(systemName: "lock")
                                        .foregroundColor(AppColors.main)
                                    if showPassword {
                                        TextField("Password", text: $password)
                                            .autocapitalization(.none)
                                            .disableAutocorrection(true)
                                            .onChange(of: password) { oldValue, newValue in
                                                if !password.isEmpty {
                                                    _ = validatePassword()
                                                } else {
                                                    passwordError = nil
                                                }
                                            }
                                    } else {
                                        SecureField("Password", text: $password)
                                            .autocapitalization(.none)
                                            .disableAutocorrection(true)
                                            .onChange(of: password) { oldValue, newValue in
                                                if !password.isEmpty {
                                                    _ = validatePassword()
                                                } else {
                                                    passwordError = nil
                                                }
                                            }
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
                                        .stroke(passwordError == nil ? AppColors.main.opacity(0.15) : Color.red, lineWidth: 1)
                                )
                                
                                if let error = passwordError {
                                    Text(error)
                                        .font(.caption)
                                        .foregroundColor(.red)
                                        .padding(.horizontal, 8)
                                }
                            }
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
                            if validateForm() {
                                // For demo purposes, any valid email/password combination works
                                isLoggedIn = true
                            } else {
                                // Show alert for invalid form
                                alertMessage = "Please correct the errors in the form"
                                showAlert = true
                            }
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
            .alert("Form Error", isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(alertMessage)
            }
        }
    }
}

#Preview {
    LoginView()
}
