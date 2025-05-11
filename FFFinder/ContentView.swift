//
//  ContentView.swift
//  FFFinder
//
//  Created by ZZ on 2025.05.06.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = FestivalsViewModel()
    @StateObject private var notificationVM = NotificationViewModel()
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView(viewModel: viewModel)
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(0)
            
            AllFestivalsView(viewModel: viewModel)
                .tabItem {
                    Label("All Festivals", systemImage: "film")
                }
                .tag(1)
            
            FavoritesView(viewModel: viewModel)
                .tabItem {
                    Label("Favorites", systemImage: "heart.fill")
                }
                .tag(2)
            
            ProfileView(notificationVM: notificationVM)
                .tabItem {
                        Label("Profile", systemImage: "person.fill")
                }
                .tag(3)
        }
        .accentColor(AppColors.accent)
        .background(AppColors.background)
        
        .onAppear {
            viewModel.notificationVM = notificationVM
        }
    }
}

#Preview {
    ContentView()
}
