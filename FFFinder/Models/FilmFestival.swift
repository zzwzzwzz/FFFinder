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
					 imageURL: "sff_logo",
					 genres: ["International", "Features", "Documentary", "Short Films"],
					 ticketPrice: "$20-25"),
		
		FilmFestival(name: "Flickerfest",
					 dateRange: "January 21-30, 2025",
					 description: "Australia's leading short film festival held at Bondi Beach. Flickerfest is Australia's only Academy® Qualifying and BAFTA Recognised short film festival with selected films being eligible for Academy® and BAFTA award nomination.",
					 website: "https://www.flickerfest.com.au",
					 location: "Bondi Beach Pavilion",
					 established: 1991,
					 imageURL: "flickerfest_logo",
					 genres: ["Short Films", "Animation", "Documentary"],
					 ticketPrice: "$15-22"),
		
		FilmFestival(name: "Japanese Film Festival",
					 dateRange: "November 10-20, 2025",
					 description: "Showcasing the best of contemporary Japanese cinema. The Japanese Film Festival (JFF) is an annual film festival that has been presented by The Japan Foundation, Sydney since 1997.",
					 website: "https://japanesefilmfestival.net",
					 location: "Event Cinemas George Street",
					 established: 1997,
					 imageURL: "jff_logo",
					 genres: ["Japanese", "International", "Animation"],
					 ticketPrice: "$18-22"),
		
		FilmFestival(name: "Queer Screen Film Fest",
					 dateRange: "September 15-25, 2025",
					 description: "LGBTQ+ films from around the world, celebrating diversity in storytelling. Queer Screen Film Fest showcases LGBTIQ+ films from Australia and beyond.",
					 website: "https://queerscreen.org.au",
					 location: "Event Cinemas George Street",
					 established: 1993,
					 imageURL: "queerscreen_logo",
					 genres: ["LGBTQ+", "Drama", "Documentary"],
					 ticketPrice: "$15-20"),
		
		FilmFestival(name: "Sydney Underground Film Festival",
					 dateRange: "September 12-15, 2025",
					 description: "Showcasing the best in independent, experimental, and underground cinema from Australia and around the world.",
					 website: "https://www.suff.com.au",
					 location: "Marrickville",
					 established: 2007,
					 imageURL: "suff_logo",
					 genres: ["Independent", "Experimental", "Underground"],
					 ticketPrice: "$15-25"),
		
		FilmFestival(name: "Sydney Science Fiction Film Festival",
					 dateRange: "October 5-8, 2025",
					 description: "Dedicated to science fiction, fantasy, and horror films from around the world.",
					 website: "https://www.sydneyscififilmfestival.com",
					 location: "Ritz Cinema Randwick",
					 established: 2015,
					 imageURL: "scifi_logo",
					 genres: ["Science Fiction", "Fantasy", "Horror"],
					 ticketPrice: "$18-25"),
		
		FilmFestival(name: "Sydney Women's International Film Festival",
					 dateRange: "March 8-15, 2025",
					 description: "Celebrating women in film, showcasing works by female filmmakers from around the world.",
					 website: "https://www.swiff.com.au",
					 location: "Various locations",
					 established: 2010,
					 imageURL: "swiff_logo",
					 genres: ["Women Directors", "International", "Documentary"],
					 ticketPrice: "$15-20"),
		
		FilmFestival(name: "Sydney Latin American Film Festival",
					 dateRange: "August 15-25, 2025",
					 description: "Showcasing the best of Latin American cinema, including features, documentaries, and short films.",
					 website: "https://www.slaff.com.au",
					 location: "Various locations",
					 established: 2008,
					 imageURL: "slaff_logo",
					 genres: ["Latin American", "International", "Documentary"],
					 ticketPrice: "$15-20"),
		
		FilmFestival(name: "Antenna Documentary Film Festival",
					 dateRange: "February 6–16, 2025",
					 description: "Australia’s leading international non-fiction film festival, showcasing 50 of the most creative, thought-provoking documentaries from around the globe over 11 days.",
					 website: "https://antennafestival.org",
					 location: "Various venues across Sydney",
					 established: 2011,
					 imageURL: "antenna_logo",
					 genres: ["Documentary", "International", "Non-Fiction"],
					 ticketPrice: "$15–25"),

		FilmFestival(name: "Queer Screen Mardi Gras Film Festival",
					 dateRange: "February 13–27, 2025",
					 description: "Celebrating LGBTQIA+ stories from around the world, this festival is a key event of the Sydney Gay and Lesbian Mardi Gras, featuring almost 150 films.",
					 website: "https://queerscreen.org.au",
					 location: "Various venues across Sydney",
					 established: 1993,
					 imageURL: "mardi_gras_logo",
					 genres: ["LGBTQ+", "Drama", "Documentary", "International"],
					 ticketPrice: "$15–22"),

		FilmFestival(name: "Europa! Europa Film Festival",
					 dateRange: "February 13–March 12, 2025",
					 description: "A celebration of European cinema, featuring 44 films from 26 countries, including comedies, dramas, and box office hits.",
					 website: "https://www.europafilmfestival.com.au",
					 location: "Ritz Cinemas, Randwick",
					 established: 2022,
					 imageURL: "europa_europa_logo",
					 genres: ["European", "International", "Drama", "Comedy"],
					 ticketPrice: "$21–26")

	]
}
