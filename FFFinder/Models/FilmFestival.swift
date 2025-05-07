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
	var isFavorite: Bool = false
	
	// Added fields
	let imageURL: String?
	let genres: [String]
	let ticketPrice: String?
	
	static let samples = [
		FilmFestival(name: "Sydney Film Festival",
					 dateRange: "June 5-16, 2025",
					 description: "Sydney's premier film event showcasing the best in world cinema. Founded in 1954, Sydney Film Festival is one of the world's longest-running film festivals. The festival screens feature films, documentaries, short films and animations across Sydney.",
					 website: "https://www.sff.org.au",
					 location: "Various locations across Sydney",
					 established: 1954,
					 imageURL: nil,
					 genres: ["International", "Features", "Documentary", "Short Films"],
					 ticketPrice: "$20-25"),
		
		FilmFestival(name: "Flickerfest",
					 dateRange: "January 21-30, 2025",
					 description: "Australia's leading short film festival held at Bondi Beach. Flickerfest is Australia's only Academy® Qualifying and BAFTA Recognised short film festival with selected films being eligible for Academy® and BAFTA award nomination.",
					 website: "https://www.flickerfest.com.au",
					 location: "Bondi Beach Pavilion",
					 established: 1991,
					 imageURL: nil,
					 genres: ["Short Films", "Animation", "Documentary"],
					 ticketPrice: "$15-22"),
		
		FilmFestival(name: "Japanese Film Festival",
					 dateRange: "November 10-20, 2025",
					 description: "Showcasing the best of contemporary Japanese cinema. The Japanese Film Festival (JFF) is an annual film festival that has been presented by The Japan Foundation, Sydney since 1997.",
					 website: "https://japanesefilmfestival.net",
					 location: "Event Cinemas George Street",
					 established: 1997,
					 imageURL: nil,
					 genres: ["Japanese", "International", "Animation"],
					 ticketPrice: "$18-22"),
		
		FilmFestival(name: "Queer Screen Film Fest",
					 dateRange: "September 15-25, 2025",
					 description: "LGBTQ+ films from around the world, celebrating diversity in storytelling. Queer Screen Film Fest showcases LGBTIQ+ films from Australia and beyond.",
					 website: "https://queerscreen.org.au",
					 location: "Event Cinemas George Street",
					 established: 1993,
					 imageURL: nil,
					 genres: ["LGBTQ+", "Drama", "Documentary"],
					 ticketPrice: "$15-20")
	]
}
