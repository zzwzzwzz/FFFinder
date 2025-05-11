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
	
	func isFavorite(festival: FilmFestival) -> Bool {
		return favoriteIds.contains(festival.id)
	}
	
	func getFavoriteFestivals() -> [FilmFestival] {
		return festivals.filter { favoriteIds.contains($0.id) }
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
}
