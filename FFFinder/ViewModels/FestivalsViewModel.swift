//
//  FestivalsViewModel.swift
//  FFFinder
//
//  Created by ZZ on 2025.05.07.
//

import Foundation

class FestivalsViewModel: ObservableObject {
	@Published var festivals: [FilmFestival] = []
	
	init() {
		loadFestivals()
	}
	
	private func loadFestivals() {
		// Sample data
		festivals = FilmFestival.samples
	}
	
	func toggleFavorite(for festival: FilmFestival) {
		// Implement later to allow user to favorite festivals
	}
}
