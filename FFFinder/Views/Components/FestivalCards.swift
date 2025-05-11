//
//  FestivalCards.swift
//  FFFinder
//
//  Created by ZZ on 2025.05.07.
//

import SwiftUI

struct UpcomingFestivalCard: View {
	let festival: FilmFestival
	
	// Compute days remaining until festival starts
	var daysRemaining: Int {
		let calendar = Calendar.current
		let today = calendar.startOfDay(for: Date())
		let festivalStart = calendar.startOfDay(for: festival.startDate)
		
		if let days = calendar.dateComponents([.day], from: today, to: festivalStart).day {
			return max(0, days)
		}
		return 0
	}
	
	// Color for countdown badge based on proximity
	var countdownColor: Color {
		if daysRemaining < 7 {
			return .red
		} else if daysRemaining < 30 {
			return .orange
		} else {
			return .blue
		}
	}
	
	var body: some View {
		VStack(alignment: .leading) {
			ZStack(alignment: .bottomLeading) {
				// Festival image if available, placeholder otherwise
				if let imageURL = festival.imageURL {
					Image(imageURL)
						.resizable()
						.aspectRatio(16/9, contentMode: .fit)
						.cornerRadius(8, corners: [.topLeft, .topRight])
				} else {
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
				}
				
				// Festival info overlay
				VStack(alignment: .leading, spacing: 4) {
					HStack {
						Text(festival.dateRange)
							.font(.caption)
							.foregroundColor(.white)
						Spacer()
						if daysRemaining > 0 {
							Text("\(daysRemaining)d")
								.font(.caption2)
								.fontWeight(.bold)
								.padding(.horizontal, 6)
								.padding(.vertical, 2)
								.background(countdownColor)
								.foregroundColor(.white)
								.cornerRadius(4)
						}
					}
				}
				.frame(width: 220, alignment: .leading)
				.padding(8)
				.background(
					LinearGradient(
						gradient: Gradient(colors: [.black.opacity(0.7), .clear]),
						startPoint: .bottom,
						endPoint: .top
					)
				)
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

// Extension to create rounded corners only on certain sides
extension View {
	func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
		clipShape(RoundedCorner(radius: radius, corners: corners))
	}
}

struct RoundedCorner: Shape {
	var radius: CGFloat = .infinity
	var corners: UIRectCorner = .allCorners
	
	func path(in rect: CGRect) -> Path {
		let path = UIBezierPath(
			roundedRect: rect,
			byRoundingCorners: corners,
			cornerRadii: CGSize(width: radius, height: radius)
		)
		return Path(path.cgPath)
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
