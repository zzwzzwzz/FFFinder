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
    
    private var topSafeAreaInset: CGFloat {
        (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.safeAreaInsets.top ?? 44
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                // Header Image
                ZStack(alignment: .top) {
                    if let posterURL = film.posterImageURL {
                        AsyncImage(url: posterURL) { phase in
                            switch phase {
                            case .empty:
                                Rectangle()
                                    .fill(Color.gray.opacity(0.2))
                                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 3 / 2)
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(2/3, contentMode: .fill)
                                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 3 / 2)
                                    .clipped()
                            case .failure:
                                Rectangle()
                                    .fill(Color.gray.opacity(0.2))
                                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 3 / 2)
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
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 3 / 2)
                            .overlay(
                                Image(systemName: "film")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 60)
                                    .foregroundColor(.gray)
                            )
                    }
                    
                    // Gradient overlay at bottom for text readability
                    VStack {
                        Spacer()
                        LinearGradient(
                            gradient: Gradient(colors: [.clear, .black.opacity(0.7)]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .frame(height: 120)
                    }
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 3 / 2)
                    // Custom top bar
                    HStack {
                        Button(action: {
                            dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                                .padding(10)
                                .background(Color.black.opacity(0.3))
                                .clipShape(Circle())
                        }
                        .padding(.leading, 16)
                        Spacer()
                        Button(action: {
                            viewModel.toggleFavoriteFilm(for: film)
                        }) {
                            Image(systemName: viewModel.isFavoriteFilm(film: film) ? "heart.fill" : "heart")
                                .foregroundColor(viewModel.isFavoriteFilm(film: film) ? .red : .white)
                                .padding(10)
                                .background(Color.black.opacity(0.3))
                                .clipShape(Circle())
                        }
                        .padding(.trailing, 16)
                    }
                    .padding(.top, topSafeAreaInset)
                    .frame(width: UIScreen.main.bounds.width)
					
                    // Film title at bottom
                    VStack {
                        Spacer()
                        HStack(alignment: .bottom) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(film.title)
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                Text("\(film.year) • Directed by \(film.director)")
                                    .font(.subheadline)
                                    .foregroundColor(.white.opacity(0.9))
                                    .padding(.bottom, 10)
                                Text(film.description)
                                    .font(.body)
                                    .foregroundColor(.white)
                            }
                            .padding(.horizontal)
                            .padding(.bottom, 16)
                            Spacer()
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 3 / 2)
                }
                
                // Content
                VStack(alignment: .leading, spacing: 24) {
                    
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
                        Text("Links")
                            .font(.headline)
                            .foregroundColor(AppColors.main)
                        HStack(spacing: 32) {
                            ForEach(ExternalLink.allCases, id: \.self) { link in
                                if let url = link.url(for: film) {
                                    Link(destination: url) {
                                        VStack(spacing: 6) {
                                            ZStack {
                                                Circle()
                                                    .fill(Color(.systemGray6))
                                                    .frame(width: 54, height: 54)
                                                    .shadow(color: .black.opacity(0.07), radius: 4, x: 0, y: 2)
                                                Image(link.iconName)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 32, height: 32)
                                            }
                                            Text(link.label)
                                                .font(.caption2)
                                                .foregroundColor(.secondary)
                                        }
                                        .contentShape(Rectangle())
                                        .buttonStyle(PlainButtonStyle())
                                        .opacity(0.95)
                                        .scaleEffect(1.0)
                                        .animation(.easeInOut(duration: 0.15), value: UUID())
                                    }
                                }
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background(Color(.systemGray5))
                        .cornerRadius(16)
                    }
                }
                .padding()
            }
        }
        .edgesIgnoringSafeArea(.top)
        .toolbar(.hidden, for: .navigationBar)
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

enum ExternalLink: CaseIterable {
    case imdb, letterboxd, rotten
    
    var iconName: String {
        switch self {
        case .imdb: return "imdb_logo"
        case .letterboxd: return "letterboxd_logo"
        case .rotten: return "rt_logo"
        }
    }
    var label: String {
        switch self {
        case .imdb: return "IMDb"
        case .letterboxd: return "Letterboxd"
        case .rotten: return "Rotten Tomato"
        }
    }
    func url(for film: Film) -> URL? {
        switch self {
        case .imdb: return URL(string: film.imdbURL)
        case .letterboxd: return URL(string: film.letterboxdURL)
        case .rotten: return URL(string: film.rottenTomatoesURL)
        }
    }
} 
