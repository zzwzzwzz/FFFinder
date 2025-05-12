//
//  FavoritesView.swift
//  FFFinder
//
//  Created by ZZ on 2025.05.07.
//

import SwiftUI

struct FavoritesView: View {
	@ObservedObject var viewModel: FestivalsViewModel
	@State private var selectedTab = 0
	@State private var showingExportSheet = false
	
	var body: some View {
		NavigationStack {
			ZStack {
				Color("BackgroundColor")
					.edgesIgnoringSafeArea(.all)
				
				VStack(spacing: 0) {
					// Header
					HStack {
						Text("Your Favorites")
							.font(.title)
							.fontWeight(.bold)
						
						Spacer()
						
						if selectedTab == 1 && !viewModel.favoriteFilmIds.isEmpty {
							Button {
								showingExportSheet = true
							} label: {
								Image(systemName: "square.and.arrow.up")
									.font(.title3)
									.foregroundColor(AppColors.main)
							}
						}
					}
					.frame(maxWidth: .infinity, alignment: .leading)
					.padding(.horizontal)
					.padding(.top)
					.padding(.bottom, 8)
					
					// Tab Selector
					HStack(spacing: 0) {
						TabButton(title: "Festivals", isSelected: selectedTab == 0) {
							selectedTab = 0
						}
						
						TabButton(title: "Films", isSelected: selectedTab == 1) {
							selectedTab = 1
						}
					}
					.padding(.horizontal)
					.padding(.bottom, 16)
					
					if selectedTab == 0 {
						if viewModel.favoriteIds.isEmpty {
							EmptyFavoritesView(message: "No favorite festivals yet")
						} else {
							FavoriteFestivalsSection(viewModel: viewModel)
						}
					} else {
						if viewModel.favoriteFilmIds.isEmpty {
							EmptyFavoritesView(message: "No favorite films yet")
						} else {
							FavoriteFilmsSection(viewModel: viewModel)
						}
					}
				}
			}
			.navigationBarTitleDisplayMode(.inline)
			.sheet(isPresented: $showingExportSheet) {
				FilmPosterExportView(films: viewModel.getFavoriteFilms(), viewModel: viewModel)
			}
		}
	}
}

struct TabButton: View {
	let title: String
	let isSelected: Bool
	let action: () -> Void
	
	var body: some View {
		Button(action: action) {
			Text(title)
				.font(.headline)
				.foregroundColor(isSelected ? AppColors.main : .gray)
				.padding(.vertical, 8)
				.frame(maxWidth: .infinity)
				.background(
					VStack {
						Spacer()
						Rectangle()
							.fill(isSelected ? AppColors.main : Color.clear)
							.frame(height: 2)
					}
				)
		}
	}
}

struct EmptyFavoritesView: View {
	let message: String
	
	var body: some View {
		VStack(spacing: 24) {
			Spacer()
			Image(systemName: "heart.fill")
				.font(.system(size: 60))
				.foregroundColor(AppColors.main)
			Text(message)
				.font(.title2)
				.fontWeight(.semibold)
				.foregroundColor(AppColors.main)
			Text("Tap the heart icon to add it to your favorites")
				.font(.body)
				.foregroundColor(AppColors.main.opacity(0.8))
				.multilineTextAlignment(.center)
				.padding(.horizontal, 40)
			Spacer()
		}
	}
}

struct FavoriteFestivalsSection: View {
	@ObservedObject var viewModel: FestivalsViewModel
	
	var body: some View {
		ScrollView {
			LazyVGrid(columns: [
				GridItem(.flexible(), spacing: 20),
				GridItem(.flexible(), spacing: 20)
			], spacing: 20) {
				ForEach(viewModel.getFavoriteFestivals()) { festival in
					NavigationLink(destination: FestivalDetailView(festival: festival, viewModel: viewModel)) {
						FestivalsGridItem(festival: festival)
					}
				}
			}
			.padding(.horizontal)
		}
	}
}

struct FavoriteFilmsSection: View {
	@ObservedObject var viewModel: FestivalsViewModel
	
	var body: some View {
		ScrollView {
			LazyVGrid(columns: [
				GridItem(.flexible(), spacing: 20),
				GridItem(.flexible(), spacing: 20)
			], spacing: 20) {
				ForEach(viewModel.getFavoriteFilms()) { film in
					NavigationLink(destination: FilmDetailView(film: film, viewModel: viewModel)) {
						FilmGridItem(film: film, viewModel: viewModel)
					}
				}
			}
			.padding(.horizontal)
		}
	}
}

struct FestivalsGridItem: View {
	let festival: FilmFestival
	
	var body: some View {
		VStack(alignment: .leading, spacing: 8) {
			// Festival Image
			if let imageURL = festival.imageURL {
				Image(imageURL)
					.resizable()
					.aspectRatio(contentMode: .fill)
					.frame(height: 160)
					.clipped()
					.cornerRadius(12)
			} else {
				Rectangle()
					.fill(Color.gray.opacity(0.2))
					.frame(height: 160)
					.cornerRadius(12)
					.overlay(
						Image(systemName: "film")
							.font(.system(size: 40))
							.foregroundColor(.gray)
					)
			}
			
			// Festival Info
			VStack(alignment: .leading, spacing: 4) {
				Text(festival.name)
					.font(.headline)
					.lineLimit(2)
					.foregroundColor(.primary)
					.frame(height: 44, alignment: .topLeading)
					.frame(maxWidth: .infinity, alignment: .leading)
					.multilineTextAlignment(.leading)
				
				Text(festival.dateRange)
					.font(.subheadline)
					.foregroundColor(.secondary)
					.lineLimit(1)
					.frame(height: 20)
					.frame(maxWidth: .infinity, alignment: .leading)
				
				Text(festival.location)
					.font(.caption)
					.foregroundColor(.secondary)
					.lineLimit(1)
					.frame(height: 16)
					.frame(maxWidth: .infinity, alignment: .leading)
			}
		}
		.frame(width: UIScreen.main.bounds.width / 2 - 40)
		.padding(12)
		.background(Color("CardBackground"))
		.cornerRadius(16)
		.shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 2)
	}
}

struct FilmGridItem: View {
	let film: Film
	@ObservedObject var viewModel: FestivalsViewModel
	
	var body: some View {
		VStack(alignment: .leading, spacing: 8) {
			// Poster Image
			if let posterURL = film.posterImageURL {
				AsyncImage(url: posterURL) { phase in
					switch phase {
					case .empty:
						FilmPosterPlaceholder(title: film.title)
					case .success(let image):
						image
							.resizable()
							.aspectRatio(contentMode: .fill)
							.frame(height: 240)
							.clipped()
							.cornerRadius(12)
					case .failure:
						FilmPosterPlaceholder(title: film.title)
					@unknown default:
						EmptyView()
					}
				}
			} else {
				FilmPosterPlaceholder(title: film.title)
			}
			
			// Film Info
			VStack(alignment: .leading, spacing: 4) {
				Text(film.title)
					.font(.headline)
					.lineLimit(2)
					.foregroundColor(.primary)
					.frame(height: 44, alignment: .topLeading)
					.frame(maxWidth: .infinity, alignment: .leading)
					.multilineTextAlignment(.leading)
				
				Text("\(film.year)")
					.font(.subheadline)
					.foregroundColor(.secondary)
					.lineLimit(1)
					.frame(height: 20)
					.frame(maxWidth: .infinity, alignment: .leading)
				
				Text(film.director)
					.font(.caption)
					.foregroundColor(.secondary)
					.lineLimit(1)
					.frame(height: 16)
					.frame(maxWidth: .infinity, alignment: .leading)
			}
		}
		.frame(width: UIScreen.main.bounds.width / 2 - 40)
		.padding(12)
		.background(Color("CardBackground"))
		.cornerRadius(16)
		.shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 2)
		.onAppear {
			if film.tmdbPosterPath == nil {
				Task {
					await viewModel.fetchTMDBPoster(for: film)
				}
			}
		}
	}
}

struct PosterPlaceholder: View {
	let title: String
	
	var body: some View {
		ZStack {
			Rectangle()
				.fill(Color.black)
				.frame(height: 160)
				.cornerRadius(12)
			
			VStack(spacing: 12) {
				Image(systemName: "film")
					.font(.system(size: 32))
					.foregroundColor(.gray)
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity)
		}
	}
}

#Preview {
	FavoritesView(viewModel: FestivalsViewModel())
}
