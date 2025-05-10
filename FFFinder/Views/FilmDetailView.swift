import SwiftUI

struct FilmDetailView: View {
    let film: Film
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                // Header Image
                ZStack(alignment: .bottom) {
                    if let posterURL = film.posterURL {
                        Image(posterURL)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 400)
                            .clipped()
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
                    VStack(alignment: .leading, spacing: 4) {
                        Text(film.title)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Text("\(film.year) • Directed by \(film.director)")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.9))
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
                            VStack(alignment: .leading, spacing: 4) {
                                HStack {
                                    Text(award.award)
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                    
                                    Spacer()
                                    
                                    Text("\(award.year)")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                
                                Link(destination: URL(string: award.festivalURL)!) {
                                    Text(award.festival)
                                        .font(.caption)
                                        .foregroundColor(AppColors.main)
                                }
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
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
    }
}

#Preview {
    NavigationStack {
        FilmDetailView(film: Film.samples[0])
    }
} 