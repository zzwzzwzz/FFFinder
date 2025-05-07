//
//  ContentView.swift
//  FFFinder
//
//  Created by ZZ on 2025.05.06.
//

import SwiftUI

struct ContentView: View {
	@StateObject private var viewModel = FestivalsViewModel()
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
						Text("SYDNEY")
							.font(.title2)
							.fontWeight(.light)
						Text("FILM FESTIVALS")
							.font(.title2)
							.fontWeight(.bold)
						Spacer()
					}
					.padding(.horizontal)
					.padding(.top, 8)
					
					// Search bar
					HStack {
						Image(systemName: "magnifyingglass")
							.foregroundColor(.gray)
						TextField("Search festivals", text: $searchText)
							.font(.body)
						
						if !searchText.isEmpty {
							Button {
								searchText = ""
							} label: {
								Image(systemName: "xmark.circle.fill")
									.foregroundColor(.gray)
							}
						}
					}
					.padding(10)
					.background(Color(.systemGray6))
					.cornerRadius(10)
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
									NavigationLink(destination: FestivalDetailView(festival: festival)) {
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
								NavigationLink(destination: FestivalDetailView(festival: festival)) {
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

struct UpcomingFestivalCard: View {
	let festival: FilmFestival
	
	var body: some View {
		VStack(alignment: .leading) {
			ZStack(alignment: .bottomLeading) {
				// Placeholder image
				Rectangle()
					.fill(Color.gray.opacity(0.3))
					.aspectRatio(16/9, contentMode: .fit)
					.overlay(
						Image(systemName: "film")
							.resizable()
							.scaledToFit()
							.frame(width: 40)
							.foregroundColor(.gray)
					)
				
				// Festival date badge
				Text(festival.dateRange)
					.font(.caption)
					.padding(6)
					.background(Color.black.opacity(0.7))
					.foregroundColor(.white)
					.cornerRadius(4)
					.padding(8)
			}
			
			Text(festival.name)
				.font(.headline)
				.lineLimit(1)
				.padding(.horizontal, 8)
				.padding(.top, 4)
			
			Text(festival.location)
				.font(.caption)
				.foregroundColor(.secondary)
				.lineLimit(1)
				.padding(.horizontal, 8)
				.padding(.bottom, 8)
		}
		.background(Color("CardBackground"))
		.cornerRadius(10)
		.shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
		.frame(width: 220)
	}
}

struct FestivalListItem: View {
	let festival: FilmFestival
	
	var body: some View {
		HStack(spacing: 16) {
			// Placeholder image
			Circle()
				.fill(Color.gray.opacity(0.3))
				.frame(width: 50, height: 50)
				.overlay(
					Image(systemName: "film")
						.foregroundColor(.gray)
				)
			
			VStack(alignment: .leading, spacing: 4) {
				Text(festival.name)
					.font(.headline)
				
				Text(festival.dateRange)
					.font(.subheadline)
					.foregroundColor(.secondary)
				
				Text(festival.location)
					.font(.caption)
					.foregroundColor(.secondary)
			}
		}
		.padding(.vertical, 4)
	}
}

#Preview {
	ContentView()
}
