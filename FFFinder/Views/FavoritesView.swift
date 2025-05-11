//
//  FavoritesView.swift
//  FFFinder
//
//  Created by ZZ on 2025.05.07.
//

import SwiftUI

struct FavoritesView: View {
	@ObservedObject var viewModel: FestivalsViewModel
	
	var body: some View {
		NavigationStack {
			ZStack {
				Color("BackgroundColor")
					.edgesIgnoringSafeArea(.all)
				
				VStack {
					Text("Your Favorites")
						.font(.title)
						.fontWeight(.bold)
						.frame(maxWidth: .infinity, alignment: .leading)
						.padding()
					
					if viewModel.favoriteIds.isEmpty && viewModel.favoriteFilmIds.isEmpty {
						EmptyFavoritesView()
					} else {
						FavoritesContentView(viewModel: viewModel)
					}
				}
			}
			.navigationBarHidden(true)
		}
	}
}

struct EmptyFavoritesView: View {
	var body: some View {
		VStack(spacing: 20) {
			Spacer()
			Image(systemName: "heart.fill")
				.font(.system(size: 60))
				.foregroundColor(AppColors.main)
			Text("No favorites yet")
				.font(.title2)
				.foregroundColor(AppColors.main)
			Text("Tap the heart icon on a festival or film to add it to your favorites")
				.font(.body)
				.foregroundColor(AppColors.main)
				.multilineTextAlignment(.center)
				.padding(.horizontal, 40)
			Spacer()
		}
	}
}

struct FavoritesContentView: View {
	@ObservedObject var viewModel: FestivalsViewModel
	
	var body: some View {
		ScrollView {
			VStack(spacing: 20) {
				if !viewModel.favoriteIds.isEmpty {
					FavoriteFestivalsSection(viewModel: viewModel)
				}
				
				if !viewModel.favoriteFilmIds.isEmpty {
					FavoriteFilmsSection(viewModel: viewModel)
				}
			}
			.padding(.vertical)
		}
	}
}

struct FavoriteFestivalsSection: View {
	@ObservedObject var viewModel: FestivalsViewModel
	
	var body: some View {
		VStack(alignment: .leading, spacing: 10) {
			Text("Favorite Festivals")
				.font(.title2)
				.fontWeight(.bold)
				.padding(.horizontal)
			
			ForEach(viewModel.getFavoriteFestivals()) { festival in
				NavigationLink(destination: FestivalDetailView(festival: festival, viewModel: viewModel)) {
					FestivalListItem(festival: festival)
				}
				.padding(.horizontal)
			}
		}
	}
}

struct FavoriteFilmsSection: View {
	@ObservedObject var viewModel: FestivalsViewModel
	
	var body: some View {
		VStack(alignment: .leading, spacing: 10) {
			Text("Favorite Films")
				.font(.title2)
				.fontWeight(.bold)
				.padding(.horizontal)
			
			LazyVGrid(columns: [
				GridItem(.flexible()),
				GridItem(.flexible())
			], spacing: 16) {
				ForEach(viewModel.getFavoriteFilms()) { film in
					NavigationLink(destination: FilmDetailView(film: film, viewModel: viewModel)) {
						FilmGridItem(film: film)
					}
				}
			}
			.padding(.horizontal)
		}
	}
}

struct FilmGridItem: View {
	let film: Film
	
	var body: some View {
		VStack(alignment: .leading, spacing: 8) {
			if let posterURL = film.posterURL {
				Image(posterURL)
					.resizable()
					.aspectRatio(contentMode: .fill)
					.frame(height: 200)
					.clipped()
					.cornerRadius(10)
			}
			
			Text(film.title)
				.font(.headline)
				.lineLimit(2)
			
			Text("\(film.year) • \(film.director)")
				.font(.subheadline)
				.foregroundColor(.gray)
				.lineLimit(1)
		}
		.padding(8)
		.background(Color("CardBackground"))
		.cornerRadius(12)
	}
}

#Preview {
	FavoritesView(viewModel: FestivalsViewModel())
}
