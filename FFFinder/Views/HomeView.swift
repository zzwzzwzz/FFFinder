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
	
	var featuredFestivals: [FilmFestival] {
		// First filter by search text if needed
		let festivalsToConsider = searchText.isEmpty 
			? viewModel.festivals 
			: viewModel.festivals.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
		
		// Get current date
		let today = Date()
		
		// Filter for festivals that start on or after today, and sort by start date
		return festivalsToConsider
			.filter { $0.startDate >= today }
			.sorted { $0.startDate < $1.startDate }
			.prefix(4)
			.map { $0 }
	}
	
	var featuredFilms: [Film] {
		// Get all films from all festivals and sort by number of awards (popularity)
		let allFilms = viewModel.festivals.flatMap { $0.featuredFilms }
		return allFilms.sorted { $0.awards.count > $1.awards.count }
	}
	
	var filteredFestivals: [FilmFestival] {
		let festivals = searchText.isEmpty 
			? viewModel.festivals 
			: viewModel.festivals.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
		
		// Only show festivals that start on or after today
		let today = Date()
		
		return festivals
			.filter { $0.startDate >= today }
			.sorted { $0.startDate < $1.startDate }
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
							.foregroundColor(AppColors.main)
						TextField("Search festivals", text: $searchText)
							.font(.body)
						
						if !searchText.isEmpty {
							Button {
								searchText = ""
							} label: {
								Image(systemName: "xmark.circle.fill")
									.foregroundColor(AppColors.main)
							}
						}
					}
					.padding(10)
					.background(AppColors.background)
					.cornerRadius(10)
					.overlay(
						RoundedRectangle(cornerRadius: 10)
							.stroke(AppColors.main.opacity(0.3), lineWidth: 1)
					)
					.padding(.horizontal)
					
					// Featured festivals section
					VStack(alignment: .leading) {
						Text("Upcoming Festivals")
							.font(.headline)
							.padding(.horizontal)
							.padding(.top)
						
						if featuredFestivals.isEmpty {
							VStack(alignment: .center) {
								Text("No upcoming festivals found")
									.font(.subheadline)
									.foregroundColor(.secondary)
									.padding()
							}
							.frame(maxWidth: .infinity)
							.padding(.vertical)
						} else {
							ScrollView(.horizontal, showsIndicators: false) {
								HStack(spacing: 24) {
									ForEach(featuredFestivals) { festival in
										NavigationLink(destination: FestivalDetailView(festival: festival, viewModel: viewModel)) {
											UpcomingFestivalCard(festival: festival)
										}
										.buttonStyle(PlainButtonStyle())
									}
								}
								.padding(.horizontal)
								.padding(.vertical, 8)
							}
						}
					}
					
					// Featured Films section with More button
					VStack(alignment: .leading) {
						HStack {
							Text("Featured Films")
								.font(.headline)
							
							Spacer()
							
							NavigationLink(destination: AllFestivalsView(viewModel: viewModel, initialTab: 1)) {
								Text("More")
									.foregroundColor(AppColors.main)
									.font(.subheadline)
							}
						}
						.padding(.horizontal)
						
						ScrollView {
							LazyVGrid(columns: [
								GridItem(.flexible(), spacing: 16),
								GridItem(.flexible(), spacing: 16)
							], spacing: 16) {
								ForEach(featuredFilms.prefix(4)) { film in
									NavigationLink(destination: FilmDetailView(film: film, viewModel: viewModel)) {
										FilmGridItem(film: film, viewModel: viewModel)
									}
								}
							}
							.padding(.horizontal)
						}
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
