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
	@Environment(\.dismiss) private var dismiss
	@State private var isSearching = false
	@State private var showEmptyResults = false
	@State private var hasInvalidSearchChars = false
	
	// Minimum search text length
	private let minSearchLength = 2
	// Time to wait before showing results
	private let searchDebounceTime = 0.5
	
	var genres: [String] {
		viewModel.getAvailableGenres()
	}
	
	var filteredFestivals: [FilmFestival] {
		var festivals = viewModel.festivals
		
		if !searchText.isEmpty && searchText.count >= minSearchLength {
			festivals = festivals.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
		}
		
		if let genre = selectedGenre {
			festivals = festivals.filter { $0.genres.contains(genre) }
		}
		
		return festivals
	}
	
	var filteredFilms: [Film] {
		var films = viewModel.festivals.flatMap { $0.featuredFilms }
		if !searchText.isEmpty && searchText.count >= minSearchLength {
			films = films.filter { $0.title.localizedCaseInsensitiveContains(searchText) || $0.director.localizedCaseInsensitiveContains(searchText) }
		}
		return films
	}
	
	// Check if search contains invalid characters
	private func validateSearch(_ text: String) -> Bool {
		// Simple validation to avoid SQL injection or excessive special characters
		let invalidChars = CharacterSet(charactersIn: ";\\/`'\"<>")
		return text.rangeOfCharacter(from: invalidChars) == nil
	}
	
	var body: some View {
		NavigationStack {
			ZStack {
				Color.white.ignoresSafeArea()
				VStack(spacing: 0) {
					// Header
					HStack {
						Text("Search")
							.font(.largeTitle)
							.fontWeight(.bold)
							.foregroundColor(AppColors.main)
						Spacer()
						Button(action: { dismiss() }) {
							Image(systemName: "xmark.circle.fill")
								.font(.title2)
								.foregroundColor(AppColors.main)
						}
					}
					.padding(.horizontal)
					.padding(.top, 24)
					.padding(.bottom, 10)
					
					// Search field
					VStack(spacing: 6) {
						HStack {
							Image(systemName: "magnifyingglass")
								.foregroundColor(AppColors.main)
							TextField(selectedTab == 0 ? "Search festivals" : "Search films", text: $searchText)
								.font(.body)
								.autocorrectionDisabled()
								.textInputAutocapitalization(.never)
								.onChange(of: searchText) { oldValue, newValue in
									hasInvalidSearchChars = !validateSearch(newValue)
									isSearching = true
									showEmptyResults = false
									
									// Debounce search updates
									DispatchQueue.main.asyncAfter(deadline: .now() + searchDebounceTime) {
										if searchText == newValue {
											isSearching = false
											if newValue.count >= minSearchLength {
												showEmptyResults = true
											}
										}
									}
								}
							
							if !searchText.isEmpty {
								Button {
									searchText = ""
									hasInvalidSearchChars = false
									showEmptyResults = false
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
								.stroke(hasInvalidSearchChars ? Color.red : AppColors.main.opacity(0.3), lineWidth: 1)
						)
						
						// Search validation feedback
						if hasInvalidSearchChars {
							Text("Please avoid special characters in your search")
								.font(.caption)
								.foregroundColor(.red)
								.padding(.horizontal, 4)
						} else if searchText.count > 0 && searchText.count < minSearchLength {
							Text("Type at least \(minSearchLength) characters to search")
								.font(.caption)
								.foregroundColor(.secondary)
								.padding(.horizontal, 4)
						}
					}
					.padding(.horizontal)
					.padding(.bottom, 8)
					
					
					// Results
					if isSearching {
						// Show loading indicator while searching
						VStack {
							Spacer()
							ProgressView()
								.scaleEffect(1.5)
								.padding()
							Text("Searching...")
								.foregroundColor(.secondary)
							Spacer()
						}
					} else if hasInvalidSearchChars {
						// Don't show any results for invalid search
						EmptySearchPlaceholder(type: "Invalid search")
					} else if selectedTab == 0 {
						if filteredFestivals.isEmpty && showEmptyResults {
							EmptySearchPlaceholder(type: "festivals")
						} else if !searchText.isEmpty && searchText.count >= minSearchLength || selectedGenre != nil {
							List {
								ForEach(filteredFestivals) { festival in
									NavigationLink(destination: FestivalDetailView(festival: festival, viewModel: viewModel)) {
										FestivalListItemWithLogo(festival: festival)
									}
									.listRowBackground(Color("CardBackground"))
								}
							}
							.listStyle(.plain)
						} else {
							// Show suggested festivals when not searching
							VStack(alignment: .leading) {
								Text("Popular Festivals")
									.font(.headline)
									.padding(.horizontal)
									.padding(.top, 8)
								
								List {
									ForEach(viewModel.festivals.prefix(5)) { festival in
										NavigationLink(destination: FestivalDetailView(festival: festival, viewModel: viewModel)) {
											FestivalListItemWithLogo(festival: festival)
										}
										.listRowBackground(Color("CardBackground"))
									}
								}
								.listStyle(.plain)
							}
						}
					} else {
						if filteredFilms.isEmpty && showEmptyResults {
							EmptySearchPlaceholder(type: "films")
						} else if !searchText.isEmpty && searchText.count >= minSearchLength {
							List {
								ForEach(filteredFilms) { film in
									NavigationLink(destination: FilmDetailView(film: film, viewModel: viewModel)) {
										FilmListItem(film: film, viewModel: viewModel)
									}
									.listRowBackground(Color("CardBackground"))
								}
							}
							.listStyle(.plain)
						} else {
							// Show popular films when not searching
							VStack(alignment: .leading) {
								Text("Popular Films")
									.font(.headline)
									.padding(.horizontal)
									.padding(.top, 8)
								
								List {
									let popularFilms = viewModel.festivals.flatMap { $0.featuredFilms }.sorted { $0.awards.count > $1.awards.count }.prefix(5)
									ForEach(popularFilms) { film in
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
			Image(systemName: type == "films" ? "film" : (type == "festivals" ? "film.stack" : "exclamationmark.triangle"))
				.font(.system(size: 60))
				.foregroundColor(.gray)
			Text(type == "Invalid search" ? "Invalid search terms" : "No \(type) found")
				.font(.title2)
				.foregroundColor(.gray)
				.padding(.top)
			if type == "Invalid search" {
				Text("Please remove special characters")
					.font(.subheadline)
					.foregroundColor(.gray)
			}
			Spacer()
		}
	}
}

// Film poster placeholder
struct FilmPosterPlaceholder: View {
	let title: String
	var body: some View {
		ZStack {
			Rectangle()
				.fill(Color.gray.opacity(0.2))
				.frame(width: 50, height: 75)
				.cornerRadius(8)
			
			VStack {
				Image(systemName: "film")
					.foregroundColor(.gray)
				
				Text(title.prefix(1))
					.font(.caption)
					.foregroundColor(.gray)
			}
		}
	}
}

#Preview {
	SearchView(viewModel: FestivalsViewModel())
}
