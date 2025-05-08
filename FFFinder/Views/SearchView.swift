//
//  SearchView.swift
//  FFFinder
//
//  Created by ZZ on 2025.05.07.
//

import SwiftUI

struct SearchView: View {
	@ObservedObject var viewModel: FestivalsViewModel
	@State private var searchText = ""
	@State private var selectedGenre: String?
	
	var genres: [String] {
		viewModel.getAvailableGenres()
	}
	
	var filteredFestivals: [FilmFestival] {
		var festivals = viewModel.festivals
		
		if !searchText.isEmpty {
			festivals = festivals.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
		}
		
		if let genre = selectedGenre {
			festivals = festivals.filter { $0.genres.contains(genre) }
		}
		
		return festivals
	}
	
	var body: some View {
		NavigationStack {
			ZStack {
				Color("BackgroundColor")
					.edgesIgnoringSafeArea(.all)
				
				VStack(spacing: 0) {
					// Search header
					Text("Discover Festivals")
						.font(.title)
						.fontWeight(.bold)
						.frame(maxWidth: .infinity, alignment: .leading)
						.padding()
					
					// Search field
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
					
					// Genre filters
					ScrollView(.horizontal, showsIndicators: false) {
						HStack(spacing: 10) {
							Button(action: {
								selectedGenre = nil
							}) {
								Text("All")
									.padding(.horizontal, 16)
									.padding(.vertical, 8)
									.background(
										selectedGenre == nil ?
										AppColors.primary : AppColors.background
									)
									.foregroundColor(
										selectedGenre == nil ? .white : AppColors.primary
									)
									.cornerRadius(20)
							}
							
							ForEach(genres, id: \.self) { genre in
								Button(action: {
									if selectedGenre == genre {
										selectedGenre = nil
									} else {
										selectedGenre = genre
									}
								}) {
									Text(genre)
										.padding(.horizontal, 16)
										.padding(.vertical, 8)
										.background(
											selectedGenre == genre ?
											AppColors.primary : AppColors.background
										)
										.foregroundColor(
											selectedGenre == genre ? .white : AppColors.primary
										)
										.cornerRadius(20)
								}
							}
						}
						.padding(.horizontal)
						.padding(.vertical, 8)
					}
					
					// Results
					if filteredFestivals.isEmpty {
						VStack {
							Spacer()
							Image(systemName: "film.stack")
								.font(.system(size: 60))
								.foregroundColor(.gray)
							Text("No festivals found")
								.font(.title2)
								.foregroundColor(.gray)
								.padding(.top)
							Spacer()
						}
					} else {
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
	SearchView(viewModel: FestivalsViewModel())
}
