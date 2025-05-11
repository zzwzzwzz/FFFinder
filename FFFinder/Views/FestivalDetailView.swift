//
//  FestivalDetailView.swift
//  FFFinder
//
//  Created by ZZ on 2025.05.07.
//

import SwiftUI
import MapKit
import CoreLocation

class FestivalLocationManager: ObservableObject {
	@Published var coordinate: CLLocationCoordinate2D?
	private let geocoder = CLGeocoder()
	
	func geocode(address: String) {
		geocoder.geocodeAddressString(address) { placemarks, error in
			if let location = placemarks?.first?.location {
				DispatchQueue.main.async {
					self.coordinate = location.coordinate
				}
			}
		}
	}
}

struct FestivalDetailView: View {
	let festival: FilmFestival
	@ObservedObject var viewModel: FestivalsViewModel
	@State private var isFavorite: Bool
	@State private var showingMap = false
	@State private var venueCoordinate: CLLocationCoordinate2D?
	@State private var isLoading = true
	
	init(festival: FilmFestival, viewModel: FestivalsViewModel) {
		self.festival = festival
		self.viewModel = viewModel
		_isFavorite = State(initialValue: viewModel.isFavorite(festival: festival))
	}
	
	var body: some View {
		ScrollView {
			VStack(spacing: 0) {
				// Header Image
				ZStack(alignment: .bottom) {
					if let imageURL = festival.imageURL {
						AsyncImage(url: URL(string: imageURL)) { phase in
							switch phase {
							case .empty:
								Rectangle()
									.fill(Color.gray.opacity(0.2))
									.frame(height: 300)
							case .success(let image):
								image
									.resizable()
									.aspectRatio(contentMode: .fill)
									.frame(height: 300)
									.clipped()
							case .failure:
								Rectangle()
									.fill(Color.gray.opacity(0.2))
									.frame(height: 300)
							@unknown default:
								EmptyView()
							}
						}
					} else {
						Rectangle()
							.fill(Color.gray.opacity(0.2))
							.frame(height: 300)
							.overlay(
								Image(systemName: "film")
									.resizable()
									.scaledToFit()
									.frame(width: 60)
									.foregroundColor(.gray)
							)
					}
					
					// Gradient overlay
					LinearGradient(
						gradient: Gradient(colors: [.clear, .black.opacity(0.7)]),
						startPoint: .top,
						endPoint: .bottom
					)
					.frame(height: 300)
					
					// Festival name and favorite icon
					HStack(alignment: .center, spacing: 0) {
						Text(festival.name)
							.font(.title2)
							.fontWeight(.semibold)
							.foregroundColor(.white)
							.lineLimit(2)
							.multilineTextAlignment(.leading)
						Spacer()
						Button(action: {
							viewModel.toggleFavorite(for: festival)
						}) {
							Image(systemName: viewModel.isFavorite(festival: festival) ? "heart.fill" : "heart")
								.foregroundColor(viewModel.isFavorite(festival: festival) ? .red : .white)
								.font(.title2)
						}
						.buttonStyle(PlainButtonStyle())
					}
					.frame(maxWidth: .infinity)
					.padding(.horizontal)
					.padding(.bottom, 12)
				}
				.frame(height: 300)
				
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
						if let coordinate = venueCoordinate {
							let region = MKCoordinateRegion(
								center: coordinate,
								span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
							)
							
							Map(initialPosition: .region(region)) {
								Marker(festival.name, coordinate: coordinate)
							}
							.frame(height: 160)
							.cornerRadius(8)
							.onTapGesture { showingMap = true }
							.fullScreenCover(isPresented: $showingMap) {
								ExpandedMapView(coordinate: coordinate, venueName: festival.name)
							}
						} else {
							ProgressView("Loading map...")
								.frame(height: 160)
						}
					}
					
					// Featured Films Section
					VStack(alignment: .leading, spacing: 12) {
						Text("Recent Winners")
							.font(.headline)
							.foregroundColor(AppColors.main)
						
						ScrollView(.horizontal, showsIndicators: false) {
							HStack(spacing: 16) {
								ForEach(festival.featuredFilms) { film in
									NavigationLink(destination: FilmDetailView(film: film, viewModel: viewModel)) {
										VStack(alignment: .leading) {
											// Film poster
											if let posterURL = film.posterImageURL {
												AsyncImage(url: posterURL) { phase in
													switch phase {
													case .empty:
														FilmPosterPlaceholder(title: film.title)
													case .success(let image):
														image
															.resizable()
															.aspectRatio(contentMode: .fill)
															.frame(width: 120, height: 180)
															.clipped()
															.cornerRadius(8)
													case .failure:
														FilmPosterPlaceholder(title: film.title)
													@unknown default:
														EmptyView()
													}
												}
											} else {
												FilmPosterPlaceholder(title: film.title)
											}
											
											// Film info
											VStack(alignment: .leading, spacing: 4) {
												Text(film.title)
													.font(.subheadline)
													.fontWeight(.medium)
													.lineLimit(1)
													.frame(maxWidth: .infinity, alignment: .leading)
												
												Text("\(film.year)")
													.font(.caption)
													.foregroundColor(.secondary)
													.frame(maxWidth: .infinity, alignment: .leading)
											}
											.frame(width: 120, alignment: .leading)
										}
									}
								}
							}
							.padding(.horizontal, 4)
						}
					}
				}
				.padding()
			}
		}
		.ignoresSafeArea(edges: .top)
		.navigationBarTitleDisplayMode(.inline)
		.toolbar {
			ToolbarItem(placement: .principal) {
				EmptyView()
			}
			ToolbarItem(placement: .navigationBarTrailing) {
				Button(action: {
					viewModel.toggleFavorite(for: festival)
					isFavorite.toggle()
				}) {
					Image(systemName: isFavorite ? "heart.fill" : "heart")
						.foregroundColor(isFavorite ? .red : .white)
						.font(.system(size: 20))
				}
			}
		}
		.toolbarBackground(.hidden, for: .navigationBar)
		.toolbarBackground(.visible, for: .navigationBar)
		.onAppear {
			geocodeAddress(festival.venueAddress)
			// Fetch TMDB posters for all featured films
			for film in festival.featuredFilms {
				if film.tmdbPosterPath == nil {
					Task {
						await viewModel.fetchTMDBPoster(for: film)
					}
				}
			}
		}
	}
	
	private func geocodeAddress(_ address: String) {
		let geocoder = CLGeocoder()
		geocoder.geocodeAddressString(address) { placemarks, error in
			if let location = placemarks?.first?.location {
				DispatchQueue.main.async {
					self.venueCoordinate = location.coordinate
				}
			}
		}
	}
}

private struct IdentifiableCoordinate: Identifiable {
	let id = UUID()
	let coordinate: CLLocationCoordinate2D
}

struct ExpandedMapView: View {
	let coordinate: CLLocationCoordinate2D
	let venueName: String
	@Environment(\.dismiss) private var dismiss
	var body: some View {
		VStack(spacing: 0) {
			ZStack(alignment: .topLeading) {
				let region = MKCoordinateRegion(
					center: coordinate,
					span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
				)
				
				Map(initialPosition: .region(region)) {
					Marker(venueName, coordinate: coordinate)
				}
				.edgesIgnoringSafeArea(.all)
				
				Button(action: { dismiss() }) {
					Image(systemName: "xmark.circle.fill")
						.font(.system(size: 32))
						.foregroundColor(.white)
						.shadow(radius: 4)
						.padding()
				}
			}
			Button(action: {
				let placemark = MKPlacemark(coordinate: coordinate)
				let mapItem = MKMapItem(placemark: placemark)
				mapItem.name = venueName
				mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
			}) {
				HStack {
					Image(systemName: "car.fill")
					Text("Go There")
						.fontWeight(.semibold)
				}
				.frame(maxWidth: .infinity)
				.padding()
				.background(AppColors.main)
				.foregroundColor(.white)
				.cornerRadius(12)
				.padding()
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

struct FilmPosterPlaceholder: View {
	let title: String
	
	var body: some View {
		ZStack {
			Rectangle()
				.fill(Color.black)
				.frame(width: 120, height: 180)
				.cornerRadius(8)
			
			VStack(spacing: 12) {
				Image(systemName: "film")
					.font(.system(size: 32))
					.foregroundColor(.gray)
				
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity)
		}
	}
}

#Preview {
	NavigationStack {
		FestivalDetailView(festival: FilmFestival.samples[0], viewModel: FestivalsViewModel())
	}
}
