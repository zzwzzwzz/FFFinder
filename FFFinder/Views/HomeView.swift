//
//  HomeView.swift
//  FFFinder
//
//  Created by ZZ on 2025.05.07.
//

import SwiftUI

struct HomeView: View {
	@ObservedObject var viewModel: FestivalsViewModel
	@State private var showSearch = false
	
	var featuredFestivals: [FilmFestival] {
		// Only use all festivals, no searchText
		let festivalsToConsider = viewModel.festivals
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
		let festivals = viewModel.festivals
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
				
				ScrollView {
					VStack {
						// Header
						HStack {
							// App logo
							ZStack {
								Circle()
									.fill(AppColors.main.opacity(0.15))
									.frame(width: 44, height: 44)
								Image("AppLogo")
									.resizable()
									.scaledToFill()
									.frame(width: 40, height: 40)
									.clipShape(Circle())
							}
							.overlay(
								Circle()
									.stroke(AppColors.main, lineWidth: 2)
									.frame(width: 44, height: 44)
							)
							
							Text("FFFinder")
								.font(.title)
								.bold(true)
								.foregroundColor(AppColors.main)
							
							Spacer()
							
							Button(action: { showSearch = true }) {
								Image(systemName: "magnifyingglass")
									.font(.title2)
									.foregroundColor(AppColors.main)
									.padding(10)
									.background(AppColors.background)
									.clipShape(Circle())
							}
						}
						.padding(.horizontal)
						.padding(.top, 8)
						
						// Featured festivals section
						VStack(alignment: .leading) {
							Text("Upcoming Festivals")
								.font(.headline)
								.padding(.horizontal)
								.padding(.top, 5)
								.foregroundColor(AppColors.main)
							
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
									.foregroundColor(AppColors.main)
								
								Spacer()
								
								NavigationLink(destination: AllFestivalsView(viewModel: viewModel, initialTab: 1)) {
									Text("More")
										.foregroundColor(AppColors.main)
										.font(.subheadline)
								}
							}
							.padding(.horizontal)
							.padding(.top, 5)
							.padding(.bottom, 5)
							
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
			}
			.navigationBarHidden(true)
			// Present SearchView when search icon tapped
			.sheet(isPresented: $showSearch) {
				SearchView(viewModel: viewModel)
			}
		}
	}
}

#Preview {
	HomeView(viewModel: FestivalsViewModel())
}
