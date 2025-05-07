//
//  FestivalDetailView.swift
//  FFFinder
//
//  Created by ZZ on 2025.05.07.
//

import SwiftUI
import MapKit

struct FestivalDetailView: View {
	let festival: FilmFestival
	@Environment(\.dismiss) private var dismiss
	@State private var isFavorite = false
	
	var body: some View {
		ScrollView {
			VStack(alignment: .leading, spacing: 0) {
				// Header Image
				ZStack(alignment: .bottom) {
					// Placeholder festival image
					Rectangle()
						.fill(Color.gray.opacity(0.2))
						.frame(height: 240)
						.overlay(
							Image(systemName: "film")
								.resizable()
								.scaledToFit()
								.frame(width: 80)
								.foregroundColor(.gray)
						)
					
					// Festival name overlay
					VStack(alignment: .leading) {
						HStack {
							VStack(alignment: .leading) {
								Text(festival.name)
									.font(.title)
									.fontWeight(.bold)
									.foregroundColor(.white)
								
								Text(festival.dateRange)
									.font(.headline)
									.foregroundColor(.white.opacity(0.9))
							}
							
							Spacer()
							
							Button {
								isFavorite.toggle()
							} label: {
								Image(systemName: isFavorite ? "heart.fill" : "heart")
									.font(.title2)
									.foregroundColor(isFavorite ? .red : .white)
							}
						}
					}
					.padding()
					.background(
						LinearGradient(
							gradient: Gradient(colors: [.black.opacity(0.7), .clear]),
							startPoint: .bottom,
							endPoint: .top
						)
					)
				}
				
				// Festival Info Section
				VStack(alignment: .leading, spacing: 24) {
					// Quick Info
					VStack(alignment: .leading, spacing: 16) {
						HStack(spacing: 30) {
							InfoItem(icon: "calendar", label: "Established", value: "\(festival.established)")
							InfoItem(icon: "mappin.and.ellipse", label: "Location", value: festival.location)
						}
					}
					.padding()
					.background(Color("CardBackground"))
					.cornerRadius(12)
					.shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
					
					// About Section
					VStack(alignment: .leading, spacing: 12) {
						Text("About")
							.font(.title2)
							.fontWeight(.bold)
						
						Text(festival.description)
							.font(.body)
							.lineSpacing(6)
						
						Link(destination: URL(string: festival.website)!) {
							HStack {
								Text("Visit Official Website")
								Image(systemName: "arrow.up.right.circle.fill")
							}
							.foregroundColor(.blue)
							.font(.headline)
						}
						.padding(.top, 8)
					}
					
					// Map Section
					VStack(alignment: .leading, spacing: 12) {
						Text("Location")
							.font(.title2)
							.fontWeight(.bold)
						
						// Placeholder map view 
						ZStack {
							Rectangle()
								.fill(Color.gray.opacity(0.2))
								.frame(height: 200)
								.cornerRadius(12)
							
							VStack {
								Image(systemName: "map")
									.font(.system(size: 40))
									.foregroundColor(.gray)
								
								Text("Map View")
									.foregroundColor(.gray)
							}
						}
					}
				}
				.padding()
			}
		}
		.edgesIgnoringSafeArea(.top)
		.navigationBarBackButtonHidden(true)
		.toolbar {
			ToolbarItem(placement: .navigationBarLeading) {
				Button {
					dismiss()
				} label: {
					Image(systemName: "chevron.left")
						.foregroundColor(.primary)
						.padding(8)
						.background(Color.white.opacity(0.8))
						.clipShape(Circle())
				}
			}
			
			ToolbarItem(placement: .navigationBarTrailing) {
				Button {
					// Share action
				} label: {
					Image(systemName: "square.and.arrow.up")
						.foregroundColor(.primary)
						.padding(8)
						.background(Color.white.opacity(0.8))
						.clipShape(Circle())
				}
			}
		}
	}
}

struct InfoItem: View {
	let icon: String
	let label: String
	let value: String
	
	var body: some View {
		VStack(spacing: 6) {
			Image(systemName: icon)
				.font(.system(size: 24))
				.foregroundColor(.blue)
			
			VStack(spacing: 2) {
				Text(label)
					.font(.caption)
					.foregroundColor(.secondary)
				
				Text(value)
					.font(.subheadline)
					.fontWeight(.medium)
			}
		}
	}
}

#Preview {
	NavigationStack {
		FestivalDetailView(festival: FilmFestival.samples[0])
	}
}
