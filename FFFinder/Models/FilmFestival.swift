//
//  FilmFestival.swift
//  FFFinder
//
//  Created by ZZ on 2025.05.07.
//

import Foundation

struct FilmFestival: Identifiable {
	let id = UUID()
	let name: String
	let dateRange: String
	let description: String
	let website: String
	let location: String
	let established: Int
	let isFavorite: Bool = false
	
	static let samples = [
		FilmFestival(name: "Sydney Film Festival",
					 dateRange: "June 5-16, 2025",
					 description: "Sydney's premier film event showcasing the best in world cinema.",
					 website: "https://www.sff.org.au",
					 location: "Various locations across Sydney",
					 established: 1954),
		FilmFestival(name: "Flickerfest",
					 dateRange: "January 21-30, 2025",
					 description: "Australia's leading short film festival held at Bondi Beach.",
					 website: "https://www.flickerfest.com.au",
					 location: "Bondi Beach Pavilion",
					 established: 1991),
		FilmFestival(name: "Japanese Film Festival",
					 dateRange: "November 10-20, 2025",
					 description: "Showcasing the best of contemporary Japanese cinema.",
					 website: "https://japanesefilmfestival.net",
					 location: "Event Cinemas George Street",
					 established: 1997)
	]
}
