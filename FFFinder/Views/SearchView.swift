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
	@State private var selectedTab: Int = 0 // 0 = Festivals, 1 = Films
	
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
	
	var filteredFilms: [Film] {
		var films = viewModel.festivals.flatMap { $0.featuredFilms }
		if !searchText.isEmpty {
			films = films.filter { $0.title.localizedCaseInsensitiveContains(searchText) || $0.director.localizedCaseInsensitiveContains(searchText) }
		}
		return films
	}
	
	var body: some View {
		NavigationStack {
			ZStack {
				Color.white.ignoresSafeArea()
				VStack(spacing: 0) {
					// Header
					Text("Search")
						.font(.largeTitle)
						.fontWeight(.bold)
						.foregroundColor(AppColors.main)
						.frame(maxWidth: .infinity, alignment: .leading)
						.padding(.horizontal)
						.padding(.top, 24)
						.padding(.bottom, 10)
					
					// Search field
					HStack {
						Image(systemName: "magnifyingglass")
							.foregroundColor(AppColors.main)
						TextField(selectedTab == 0 ? "Search festivals" : "Search films", text: $searchText)
							.font(.body)
							.autocorrectionDisabled()
							.textInputAutocapitalization(.never)
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
					.padding(.bottom, 8)
					
					
					// Results
					if selectedTab == 0 {
						if filteredFestivals.isEmpty {
							EmptySearchPlaceholder(type: "festivals")
						} else {
							List {
								ForEach(filteredFestivals) { festival in
									NavigationLink(destination: FestivalDetailView(festival: festival, viewModel: viewModel)) {
										FestivalListItemWithLogo(festival: festival)
									}
									.listRowBackground(Color("CardBackground"))
								}
							}
							.listStyle(.plain)
						}
					} else {
						if filteredFilms.isEmpty {
							EmptySearchPlaceholder(type: "films")
						} else {
							List {
								ForEach(filteredFilms) { film in
									NavigationLink(destination: FilmDetailView(film: film, viewModel: viewModel)) {
										FilmListItem(film: film, viewModel: viewModel)
									}
									.listRowBackground(Color("CardBackground"))
								}
							}
							.listStyle(.plain)
						}
					}
				}
			}
			.navigationBarHidden(true)
		}
	}
}

// List item for festivals with logo
struct FestivalListItemWithLogo: View {
	let festival: FilmFestival
	var body: some View {
		HStack(spacing: 16) {
			if let imageName = festival.imageURL {
				Image(imageName)
					.resizable()
					.aspectRatio(contentMode: .fit)
					.frame(width: 50, height: 50)
					.background(Color(.systemGray6))
					.clipShape(RoundedRectangle(cornerRadius: 12))
			} else {
				Rectangle()
					.fill(Color.gray.opacity(0.2))
					.frame(width: 50, height: 50)
					.cornerRadius(12)
					.overlay(
						Image(systemName: "film")
							.foregroundColor(.gray)
					)
			}
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
			Spacer()
		}
		.padding(.vertical, 8)
	}
}

// List item for films with TMDB poster
struct FilmListItem: View {
	let film: Film
	@ObservedObject var viewModel: FestivalsViewModel
	var body: some View {
		HStack(spacing: 16) {
			if let posterURL = film.posterImageURL {
				AsyncImage(url: posterURL) { phase in
					switch phase {
					case .empty:
						FilmPosterPlaceholder(title: film.title)
					case .success(let image):
						image
							.resizable()
							.aspectRatio(2/3, contentMode: .fill)
							.frame(width: 50, height: 75)
							.clipped()
							.cornerRadius(8)
					case .failure:
						FilmPosterPlaceholder(title: film.title)
					@unknown default:
						EmptyView()
					}
				}
			} else {
				FilmPosterPlaceholder(title: film.title)
			}
			VStack(alignment: .leading, spacing: 4) {
				Text(film.title)
					.font(.headline)
				Text("\(film.year)")
					.font(.subheadline)
					.foregroundColor(.secondary)
				Text(film.director)
					.font(.caption)
					.foregroundColor(.secondary)
			}
			Spacer()
		}
		.padding(.vertical, 8)
		.onAppear {
			if film.tmdbPosterPath == nil {
				Task {
					await viewModel.fetchTMDBPoster(for: film)
				}
			}
		}
	}
}

// Placeholder for empty search
struct EmptySearchPlaceholder: View {
	let type: String
	var body: some View {
		VStack {
			Spacer()
			Image(systemName: type == "films" ? "film" : "film.stack")
				.font(.system(size: 60))
				.foregroundColor(.gray)
			Text("No \(type) found")
				.font(.title2)
				.foregroundColor(.gray)
				.padding(.top)
			Spacer()
		}
	}
}

#Preview {
	SearchView(viewModel: FestivalsViewModel())
}
