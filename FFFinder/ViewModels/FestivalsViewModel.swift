//
//  FestivalsViewModel.swift
//  FFFinder
//
//  Created by ZZ on 2025.05.07.
//

import Foundation
import Combine

class FestivalsViewModel: ObservableObject {
	@Published var festivals: [FilmFestival] = []
	@Published var favoriteIds: Set<UUID> = []
	@Published var favoriteFilmIds: Set<UUID> = []
	@Published var filteredFestivals: [FilmFestival] = []
	@Published var filterGenre: String?
	
	var cancellables = Set<AnyCancellable>()
    var notificationVM: NotificationViewModel?
	
	init() {
		loadFestivals()
		
		// Setup filtering publisher
		$festivals
			.combineLatest($filterGenre)
			.map { festivals, genre -> [FilmFestival] in
				guard let genre = genre, !genre.isEmpty else {
					return festivals
				}
				return festivals.filter { $0.genres.contains(genre) }
			}
			.assign(to: &$filteredFestivals)
	}
	
	private func loadFestivals() {
		festivals = FilmFestival.samples
		filteredFestivals = festivals
	}
	
	func toggleFavorite(for festival: FilmFestival) {
		if favoriteIds.contains(festival.id) {
			favoriteIds.remove(festival.id)
		} else {
			favoriteIds.insert(festival.id)
            // send notification when add favourites
            notificationVM?.addNotification(
                title: "Festival Saved",
                message: "\(festival.name) has been added to your favorites."
                )
            }
	}
	
	func toggleFavoriteFilm(for film: Film) {
		if favoriteFilmIds.contains(film.id) {
			favoriteFilmIds.remove(film.id)
		} else {
			favoriteFilmIds.insert(film.id)
		}
	}
	
	func isFavorite(festival: FilmFestival) -> Bool {
		return favoriteIds.contains(festival.id)
	}
	
	func isFavoriteFilm(film: Film) -> Bool {
		return favoriteFilmIds.contains(film.id)
	}
	
	func getFavoriteFestivals() -> [FilmFestival] {
		return festivals.filter { favoriteIds.contains($0.id) }
	}
	
	func getFavoriteFilms() -> [Film] {
		var favoriteFilms: [Film] = []
		for festival in festivals {
			for film in festival.featuredFilms {
				if favoriteFilmIds.contains(film.id) {
					favoriteFilms.append(film)
				}
			}
		}
		return favoriteFilms
	}
	
	func getAvailableGenres() -> [String] {
		var genres = Set<String>()
		for festival in festivals {
			for genre in festival.genres {
				genres.insert(genre)
			}
		}
		return Array(genres).sorted()
	}
	
	// New method to find a festival by name
	func findFestivalByName(_ name: String) -> FilmFestival? {
		return festivals.first(where: { $0.name == name })
	}
	
	@MainActor
	func fetchTMDBPoster(for film: Film) async {
		do {
			if let tmdbMovie = try await TMDBService.shared.searchMovie(title: film.title) {
				// Update the film with TMDB data
				if let index = festivals.firstIndex(where: { festival in
					festival.featuredFilms.contains(where: { $0.id == film.id })
				}) {
					if let filmIndex = festivals[index].featuredFilms.firstIndex(where: { $0.id == film.id }) {
						var updatedFilm = festivals[index].featuredFilms[filmIndex]
						updatedFilm = Film(
							id: updatedFilm.id,
							title: updatedFilm.title,
							year: updatedFilm.year,
							director: updatedFilm.director,
							description: updatedFilm.description,
							posterURL: updatedFilm.posterURL,
							tmdbPosterPath: tmdbMovie.posterPath,
							imdbURL: updatedFilm.imdbURL,
							letterboxdURL: updatedFilm.letterboxdURL,
							rottenTomatoesURL: updatedFilm.rottenTomatoesURL,
							awards: updatedFilm.awards
						)
						festivals[index].featuredFilms[filmIndex] = updatedFilm
						objectWillChange.send()
					}
				}
			}
		} catch {
			print("Error fetching TMDB data: \(error)")
		}
	}
}
