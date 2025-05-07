//
//  FestivalCards.swift
//  FFFinder
//
//  Created by ZZ on 2025.05.07.
//

import SwiftUI

struct UpcomingFestivalCard: View {
	let festival: FilmFestival
	
	var body: some View {
		VStack(alignment: .leading) {
			ZStack(alignment: .bottomLeading) {
				// Placeholder image
				Rectangle()
					.fill(Color.gray.opacity(0.3))
					.aspectRatio(16/9, contentMode: .fit)
					.overlay(
						Image(systemName: "film")
							.resizable()
							.scaledToFit()
							.frame(width: 40)
							.foregroundColor(.gray)
					)
				
				// Festival date badge
				Text(festival.dateRange)
					.font(.caption)
					.padding(6)
					.background(Color.black.opacity(0.7))
					.foregroundColor(.white)
					.cornerRadius(4)
					.padding(8)
			}
			
			Text(festival.name)
				.font(.headline)
				.lineLimit(1)
				.padding(.horizontal, 8)
				.padding(.top, 4)
			
			Text(festival.location)
				.font(.caption)
				.foregroundColor(.secondary)
				.lineLimit(1)
				.padding(.horizontal, 8)
				.padding(.bottom, 8)
		}
		.background(Color("CardBackground"))
		.cornerRadius(10)
		.shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
		.frame(width: 220)
	}
}

struct FestivalListItem: View {
	let festival: FilmFestival
	
	var body: some View {
		HStack(spacing: 16) {
			// Placeholder image
			Circle()
				.fill(Color.gray.opacity(0.3))
				.frame(width: 50, height: 50)
				.overlay(
					Image(systemName: "film")
						.foregroundColor(.gray)
				)
			
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
		.padding(.vertical, 4)
	}
}

#Preview {
	VStack {
		UpcomingFestivalCard(festival: FilmFestival.samples[0])
		FestivalListItem(festival: FilmFestival.samples[0])
	}
	.padding()
}
