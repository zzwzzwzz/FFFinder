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
	@Environment(\.dismiss) private var dismiss
	@StateObject private var locationManager = FestivalLocationManager()
	@State private var showFullScreenMap = false
	
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
						if let coordinate = locationManager.coordinate {
							Map(coordinateRegion: .constant(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))), annotationItems: [IdentifiableCoordinate(coordinate: coordinate)]) { item in
								MapMarker(coordinate: item.coordinate)
							}
							.frame(height: 160)
							.cornerRadius(8)
							.onTapGesture { showFullScreenMap = true }
							.fullScreenCover(isPresented: $showFullScreenMap) {
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
											if let posterURL = film.posterURL {
												Image(posterURL)
													.resizable()
													.aspectRatio(contentMode: .fill)
													.frame(width: 120, height: 180)
													.clipped()
													.cornerRadius(8)
											} else {
												Rectangle()
													.fill(Color.gray.opacity(0.2))
													.frame(width: 120, height: 180)
													.cornerRadius(8)
													.overlay(
														Image(systemName: "film")
															.foregroundColor(.gray)
													)
											}
											
											// Film info
											VStack(alignment: .leading, spacing: 4) {
												Text(film.title)
													.font(.subheadline)
													.fontWeight(.medium)
													.lineLimit(1)
												
												Text("\(film.year)")
													.font(.caption)
													.foregroundColor(.secondary)
											}
											.frame(width: 120)
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
		.onAppear {
			locationManager.geocode(address: festival.venueAddress)
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
				Map(coordinateRegion: .constant(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))), annotationItems: [IdentifiableCoordinate(coordinate: coordinate)]) { item in
					MapMarker(coordinate: item.coordinate)
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

#Preview {
	NavigationStack {
		FestivalDetailView(festival: FilmFestival.samples[0], viewModel: FestivalsViewModel())
	}
}
