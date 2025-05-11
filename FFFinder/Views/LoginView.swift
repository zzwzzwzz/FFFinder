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

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Text("Welcome to Cinephiles")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 40)

                TextField("Email", text: $email)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)

                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)

              
                Button(action: {
                    isAuthenticated = true
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
            .padding()
            .navigationDestination(isPresented: $isAuthenticated) {
                ContentView()
            }
        }
    }
}

#Preview {
    LoginView()
}
