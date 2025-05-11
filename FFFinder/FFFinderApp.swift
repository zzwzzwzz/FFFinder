//
//  FFFinderApp.swift
//  FFFinder
//
//  Created by ZZ on 2025.05.06.
//

import SwiftUI

@main
struct FFFinderApp: App {
    @AppStorage("isLoggedIn") private var isLoggedIn = false

    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                ContentView()
            } else {
                LoginView()
            }
        }
    }
}
