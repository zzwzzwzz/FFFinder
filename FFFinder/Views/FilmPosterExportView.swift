//
//  FilmPosterExportView.swift
//  FFFinder
//
//  Created by ZZ on 2025.05.11.
//

import SwiftUI

struct FilmPosterExportView: View {
    let films: [Film]
    @ObservedObject var viewModel: FestivalsViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var renderedImage: UIImage?
    @State private var isLoading = true
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    // Preview
                    if let image = renderedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(12)
                            .shadow(radius: 8)
                            .padding()
                    } else {
                        ProgressView("Generating image...")
                            .frame(height: 400)
                    }
                    
                    // Share buttons
                    VStack(spacing: 16) {
                        Button {
                            if let image = renderedImage {
                                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                            }
                        } label: {
                            HStack {
                                Image(systemName: "photo")
                                Text("Save to Photos")
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.accentColor)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                        }
                        
                        Button {
                            if let image = renderedImage {
                                let activityVC = UIActivityViewController(
                                    activityItems: [image],
                                    applicationActivities: nil
                                )
                                
                                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                                   let window = windowScene.windows.first,
                                   let rootVC = window.rootViewController {
                                    rootVC.present(activityVC, animated: true)
                                }
                            }
                        } label: {
                            HStack {
                                Image(systemName: "square.and.arrow.up")
                                Text("Share")
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.accentColor)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .navigationTitle("Export Posters")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
            .task {
                await fetchPosters()
            }
        }
    }
    
    private func fetchPosters() async {
        isLoading = true
        for film in films {
            if film.tmdbPosterPath == nil {
                await viewModel.fetchTMDBPoster(for: film)
            }
        }
        isLoading = false
        generateImage()
    }
    
    private func generateImage() {
        let renderer = ImageRenderer(content: PostersGridView(films: films))
        renderer.scale = UIScreen.main.scale
        
        if let uiImage = renderer.uiImage {
            renderedImage = uiImage
        }
    }
}

private struct PostersGridView: View {
    let films: [Film]
    
    var body: some View {
        VStack(spacing: 24) {
            LazyVGrid(columns: [
                GridItem(.flexible(), spacing: 24),
                GridItem(.flexible(), spacing: 24)
            ], spacing: 24) {
                ForEach(films) { film in
                    if let posterURL = film.posterImageURL {
                        AsyncImage(url: posterURL) { phase in
                            switch phase {
                            case .empty:
                                MoviePosterPlaceholder()
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 160, height: 240)
                                    .clipped()
                                    .cornerRadius(12)
                            case .failure:
                                MoviePosterPlaceholder()
                            @unknown default:
                                EmptyView()
                            }
                        }
                    } else {
                        MoviePosterPlaceholder()
                    }
                }
            }
            .padding(24)
        }
        .frame(width: 400)
        .background(Color.white)
    }
}

private struct MoviePosterPlaceholder: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.black)
                .frame(width: 160, height: 240)
                .cornerRadius(12)
            
            Image(systemName: "film")
                .font(.system(size: 32))
                .foregroundColor(.gray)
        }
    }
} 
