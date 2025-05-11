//
//  FilmDetailView.swift
//  FFFinder
//
//  Created by ZZ on 2025.05.08.
//

import SwiftUI

struct FilmDetailView: View {
    let film: Film
    @ObservedObject var viewModel: FestivalsViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                // Header Image
                ZStack(alignment: .bottom) {
                    if let posterURL = film.posterImageURL {
                        AsyncImage(url: posterURL) { phase in
                            switch phase {
                            case .empty:
                                Rectangle()
                                    .fill(Color.gray.opacity(0.2))
                                    .frame(height: 400)
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(height: 400)
                                    .clipped()
                            case .failure:
                                Rectangle()
                                    .fill(Color.gray.opacity(0.2))
                                    .frame(height: 400)
                                    .overlay(
                                        Image(systemName: "film")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 60)
                                            .foregroundColor(.gray)
                                    )
                            @unknown default:
                                EmptyView()
                            }
                        }
                    } else {
                        Rectangle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(height: 400)
                            .overlay(
                                Image(systemName: "film")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 60)
                                    .foregroundColor(.gray)
                            )
                    }
                    
                    // Film title overlay
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(film.title)
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            Text("\(film.year) • Directed by \(film.director)")
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.9))
                        }
                        
                        Spacer()
                        
                        Button {
                            viewModel.toggleFavoriteFilm(for: film)
                        } label: {
                            Image(systemName: viewModel.isFavoriteFilm(film: film) ? "heart.fill" : "heart")
                                .font(.title3)
                                .foregroundColor(viewModel.isFavoriteFilm(film: film) ? .red : .white)
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
                    // Description
                    VStack(alignment: .leading, spacing: 12) {
                        Text("About")
                            .font(.headline)
                            .foregroundColor(AppColors.main)
                        
                        Text(film.description)
                            .font(.body)
                            .foregroundColor(.secondary)
                            .lineSpacing(4)
                    }
                    
                    // Awards Section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Awards")
                            .font(.headline)
                            .foregroundColor(AppColors.main)
                        
                        ForEach(film.awards, id: \.festival) { award in
                            // Find the festival by name for navigation
                            if let festival = viewModel.findFestivalByName(award.festival) {
                                // Wrap the entire award box in NavigationLink
                                NavigationLink(destination: FestivalDetailView(festival: festival, viewModel: viewModel)) {
                                    VStack(alignment: .leading, spacing: 4) {
                                        HStack {
                                            Text(award.award)
                                                .font(.subheadline)
                                                .fontWeight(.medium)
                                                .foregroundColor(.primary) // Ensure proper color in NavigationLink
                                            
                                            Spacer()
                                            
                                            Text("\(award.year)")
                                                .font(.subheadline)
                                                .foregroundColor(.secondary)
                                        }
                                        
                                        HStack {
                                            Text(award.festival)
                                                .font(.caption)
                                                .foregroundColor(AppColors.main)
                                            
                                            Spacer()
                                            
                                            Image(systemName: "chevron.right")
                                                .font(.caption)
                                                .foregroundColor(AppColors.main)
                                        }
                                    }
                                    .padding()
                                    .background(Color(.systemGray6))
                                    .cornerRadius(8)
                                    // Add animation effect on press
                                    .scaleEffect(1.0)
                                    .animation(.spring(response: 0.3, dampingFraction: 0.7), value: UUID()) // Using UUID() as a workaround
                                }
                                .buttonStyle(AwardButtonStyle())
                            } else {
                                // Fallback to external link if festival not found
                                Link(destination: URL(string: award.festivalURL)!) {
                                    VStack(alignment: .leading, spacing: 4) {
                                        HStack {
                                            Text(award.award)
                                                .font(.subheadline)
                                                .fontWeight(.medium)
                                                .foregroundColor(.primary)
                                            
                                            Spacer()
                                            
                                            Text("\(award.year)")
                                                .font(.subheadline)
                                                .foregroundColor(.secondary)
                                        }
                                        
                                        HStack {
                                            Text(award.festival)
                                                .font(.caption)
                                                .foregroundColor(AppColors.main)
                                            
                                            Spacer()
                                            
                                            Image(systemName: "arrow.up.right")
                                                .font(.caption)
                                                .foregroundColor(AppColors.main)
                                        }
                                    }
                                    .padding()
                                    .background(Color(.systemGray6))
                                    .cornerRadius(8)
                                }
                            }
                        }
                    }
                    
                    // External Links
                    VStack(alignment: .leading, spacing: 12) {
                        Text("More Information")
                            .font(.headline)
                            .foregroundColor(AppColors.main)
                        
                        VStack(spacing: 12) {
                            Link(destination: URL(string: film.imdbURL)!) {
                                HStack {
                                    Image("imdb_logo")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 24)
                                    Text("View on IMDb")
                                        .foregroundColor(AppColors.main)
                                    Spacer()
                                    Image(systemName: "arrow.up.right")
                                        .foregroundColor(AppColors.main)
                                }
                            }
                            
                            Link(destination: URL(string: film.letterboxdURL)!) {
                                HStack {
                                    Image("letterboxd_logo")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 24)
                                    Text("View on Letterboxd")
                                        .foregroundColor(AppColors.main)
                                    Spacer()
                                    Image(systemName: "arrow.up.right")
                                        .foregroundColor(AppColors.main)
                                }
                            }
                            
                            Link(destination: URL(string: film.rottenTomatoesURL)!) {
                                HStack {
                                    Image("rt_logo")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 24)
                                    Text("View on Rotten Tomatoes")
                                        .foregroundColor(AppColors.main)
                                    Spacer()
                                    Image(systemName: "arrow.up.right")
                                        .foregroundColor(AppColors.main)
                                }
                            }
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
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
            // Fetch TMDB poster if not already available
            if film.tmdbPosterPath == nil {
                Task {
                    await viewModel.fetchTMDBPoster(for: film)
                }
            }
        }
    }
}

// Custom button style to handle press animation
struct AwardButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .opacity(configuration.isPressed ? 0.9 : 1.0)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

#Preview {
    NavigationStack {
        FilmDetailView(film: Film.samples[0], viewModel: FestivalsViewModel())
    }
} 
