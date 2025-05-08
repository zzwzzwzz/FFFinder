//
//  HomeView.swift
//  FFFinder
//
//  Created by ZZ on 2025.05.07.
//

import SwiftUI

struct HomeView: View {
	@ObservedObject var viewModel: FestivalsViewModel
	@State private var searchText = ""
	
	var filteredFestivals: [FilmFestival] {
		if searchText.isEmpty {
			return viewModel.festivals
		} else {
			return viewModel.festivals.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
		}
	}
	
	var body: some View {
		NavigationStack {
			ZStack {
				// Background
				Color("BackgroundColor")
					.edgesIgnoringSafeArea(.all)
				
				VStack {
					// Header
					HStack {
						Text("FILM FESTIVALS")
							.font(.title2)
							.fontWeight(.bold)
						Text("FINDER")
							.font(.title2)
							.fontWeight(.light)
						Spacer()
					}
					.padding(.horizontal)
					.padding(.top, 8)
					
					// Search bar
					HStack {
						Image(systemName: "magnifyingglass")
							.foregroundColor(AppColors.primary)
						TextField("Search festivals", text: $searchText)
							.font(.body)
						
						if !searchText.isEmpty {
							Button {
								searchText = ""
							} label: {
								Image(systemName: "xmark.circle.fill")
									.foregroundColor(AppColors.primary)
							}
						}
					}
					.padding(10)
					.background(AppColors.background)
					.cornerRadius(10)
					.overlay(
						RoundedRectangle(cornerRadius: 10)
							.stroke(AppColors.primary.opacity(0.3), lineWidth: 1)
					)
					.padding(.horizontal)
					
					// Upcoming festivals section
					VStack(alignment: .leading) {
						Text("Upcoming Festivals")
							.font(.headline)
							.padding(.horizontal)
							.padding(.top)
						
						ScrollView(.horizontal, showsIndicators: false) {
							HStack(spacing: 16) {
								ForEach(filteredFestivals) { festival in
									NavigationLink(destination: FestivalDetailView(festival: festival, viewModel: viewModel)) {
										UpcomingFestivalCard(festival: festival)
									}
									.buttonStyle(PlainButtonStyle())
								}
							}
							.padding(.horizontal)
							.padding(.bottom)
						}
					}
					
					// All festivals section
					VStack(alignment: .leading) {
						Text("All Festivals")
							.font(.headline)
							.padding(.horizontal)
						
						List {
							ForEach(filteredFestivals) { festival in
								NavigationLink(destination: FestivalDetailView(festival: festival, viewModel: viewModel)) {
									FestivalListItem(festival: festival)
								}
								.listRowBackground(Color("CardBackground"))
							}
						}
						.listStyle(.plain)
					}
				}
			}
			.navigationBarHidden(true)
		}
	}
}

#Preview {
	HomeView(viewModel: FestivalsViewModel())
}
