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
	@ObservedObject var viewModel: FestivalsViewModel
	@Environment(\.dismiss) private var dismiss
	
	var body: some View {
		ScrollView {
			VStack(alignment: .leading, spacing: 0) {
				// Header Image
				ZStack(alignment: .bottom) {
					if let imageURL = festival.imageURL {
						Image(imageURL)
							.resizable()
							.aspectRatio(contentMode: .fill)
							.frame(height: 240)
							.clipped()
					} else {
						Rectangle()
							.fill(Color.gray.opacity(0.2))
							.frame(height: 240)
							.overlay(
								Image(systemName: "film")
									.resizable()
									.scaledToFit()
									.frame(width: 60)
									.foregroundColor(.gray)
							)
					}
					
					// Festival name overlay
					HStack {
						VStack(alignment: .leading, spacing: 4) {
							Text(festival.name)
								.font(.title2)
								.fontWeight(.bold)
								.foregroundColor(.white)
							
							Text(festival.dateRange)
								.font(.subheadline)
								.foregroundColor(.white.opacity(0.9))
						}
						
						Spacer()
						
						Button {
							viewModel.toggleFavorite(for: festival)
						} label: {
							Image(systemName: viewModel.isFavorite(festival: festival) ? "heart.fill" : "heart")
								.font(.title3)
								.foregroundColor(viewModel.isFavorite(festival: festival) ? .red : .white)
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
				
				// Content
				VStack(alignment: .leading, spacing: 24) {
					// Quick Info
					HStack(spacing: 0) {
						InfoItem(icon: "calendar", label: "Established", value: "\(festival.established)")
						Divider()
						InfoItem(icon: "mappin.and.ellipse", label: "Location", value: festival.location)
						Divider()
						InfoItem(icon: "link", label: "Website", value: "Visit")
							.onTapGesture {
								if let url = URL(string: festival.website) {
									UIApplication.shared.open(url)
								}
							}
					}
					.padding(.vertical, 12)
					.background(AppColors.background)
					
					// About Section
					VStack(alignment: .leading, spacing: 12) {
						Text("About")
							.font(.headline)
							.foregroundColor(AppColors.main)
						
						Text(festival.description)
							.font(.body)
							.foregroundColor(.secondary)
							.lineSpacing(4)
					}
					
					// Map Section
					VStack(alignment: .leading, spacing: 12) {
						Text("Location")
							.font(.headline)
							.foregroundColor(AppColors.main)
						
						// Placeholder map view
						ZStack {
							Rectangle()
								.fill(Color.gray.opacity(0.1))
								.frame(height: 160)
								.cornerRadius(8)
							
							VStack {
								Image(systemName: "map")
									.font(.system(size: 30))
									.foregroundColor(.gray)
								
								Text("Map View")
									.font(.subheadline)
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
						.foregroundColor(.white)
						.padding(8)
						.background(Color.black.opacity(0.3))
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
		VStack(spacing: 4) {
			Image(systemName: icon)
				.font(.system(size: 20))
				.foregroundColor(AppColors.main)
			
			Text(label)
				.font(.caption)
				.foregroundColor(.secondary)
			
			Text(value)
				.font(.subheadline)
				.fontWeight(.medium)
		}
		.frame(maxWidth: .infinity)
	}
}

#Preview {
	NavigationStack {
		FestivalDetailView(festival: FilmFestival.samples[0], viewModel: FestivalsViewModel())
	}
}
