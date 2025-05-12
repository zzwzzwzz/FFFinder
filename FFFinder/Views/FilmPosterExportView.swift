//
//  FilmPosterExportView.swift
//  FFFinder
//
//  Created by ZZ on 2025.05.11.
//

import SwiftUI
import Photos

// Class to handle image saving with Objective-C compatibility
class ImageSaver: NSObject {
    var onSuccess: () -> Void
    var onFailure: (Error) -> Void
    
    init(onSuccess: @escaping () -> Void, onFailure: @escaping (Error) -> Void) {
        self.onSuccess = onSuccess
        self.onFailure = onFailure
    }
    
    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            onFailure(error)
        } else {
            onSuccess()
        }
    }
    
    func saveImage(_ image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }
}

struct FilmPosterExportView: View {
    let films: [Film]
    @ObservedObject var viewModel: FestivalsViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var renderedImage: UIImage?
    @State private var isLoading = true
    @State private var showingSaveSuccess = false
    @State private var showingSaveError = false
    @State private var posterImages: [Film.ID: UIImage] = [:]
    @State private var errorMessage = "Please check if the app has permission to access your photos."
    
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
                    } else if isLoading {
                        VStack {
                            ProgressView()
                                .scaleEffect(1.5)
                                .padding()
                            Text("Loading posters...")
                                .foregroundColor(.secondary)
                        }
                        .frame(height: 400)
                    } else {
                        Text("No posters to display")
                            .font(.headline)
                            .foregroundColor(.secondary)
                            .frame(height: 400)
                    }
                    
                    // Share buttons
                    VStack(spacing: 16) {
                        Button {
                            saveToPhotos()
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
                        .disabled(renderedImage == nil)
                        .opacity(renderedImage == nil ? 0.5 : 1.0)
                        
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
                        .disabled(renderedImage == nil)
                        .opacity(renderedImage == nil ? 0.5 : 1.0)
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
            .alert("Saved to Photos", isPresented: $showingSaveSuccess) {
                Button("OK", role: .cancel) { }
            }
            .alert("Could not save to Photos", isPresented: $showingSaveError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(errorMessage)
            }
        }
    }
    
    private func saveToPhotos() {
        guard let image = renderedImage else { return }
        
        let imageSaver = ImageSaver(
            onSuccess: {
                showingSaveSuccess = true
            },
            onFailure: { error in
                errorMessage = error.localizedDescription
                showingSaveError = true
            }
        )
        
        imageSaver.saveImage(image)
    }
    
    private func fetchPosters() async {
        isLoading = true
        
        // First, make sure all TMDB posters are fetched
        for film in films {
            if film.tmdbPosterPath == nil {
                await viewModel.fetchTMDBPoster(for: film)
            }
        }
        
        // Next, preload the actual UIImages for each poster URL
        var loadedImages: [Film.ID: UIImage] = [:]
        
        for film in films {
            if let posterURL = film.posterImageURL {
                do {
                    let (data, _) = try await URLSession.shared.data(from: posterURL)
                    if let image = UIImage(data: data) {
                        loadedImages[film.id] = image
                    }
                } catch {
                    print("Error loading image for \(film.title): \(error)")
                }
            }
        }
        
        // Update state on main thread
        await MainActor.run {
            self.posterImages = loadedImages
            self.isLoading = false
            self.generateImage()
        }
    }
    
    private func generateImage() {
        let posterGrid = StaticPostersGridView(films: films, posterImages: posterImages)
        let renderer = ImageRenderer(content: posterGrid)
        renderer.scale = UIScreen.main.scale
        
        if let uiImage = renderer.uiImage {
            renderedImage = uiImage
        }
    }
}

private struct StaticPostersGridView: View {
    let films: [Film]
    let posterImages: [Film.ID: UIImage]
    
    var body: some View {
        VStack(spacing: 24) {
            Text("My Film Collection")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top, 24)
            
            LazyVGrid(columns: [
                GridItem(.flexible(), spacing: 24),
                GridItem(.flexible(), spacing: 24)
            ], spacing: 24) {
                ForEach(films) { film in
                    VStack(alignment: .center, spacing: 8) {
                        if let image = posterImages[film.id] {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 160, height: 240)
                                .clipped()
                                .cornerRadius(12)
                                .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
                        } else {
                            MoviePosterPlaceholder()
                        }
                        
                        Text(film.title)
                            .font(.caption)
                            .fontWeight(.medium)
                            .lineLimit(1)
                    }
                }
            }
            .padding(24)
            
            Text("Generated with FFFinder")
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.bottom, 24)
        }
        .frame(width: 400)
        .background(Color.white)
    }
}

private struct MoviePosterPlaceholder: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.gray.opacity(0.3))
                .frame(width: 160, height: 240)
                .cornerRadius(12)
            
            VStack(spacing: 8) {
                Image(systemName: "film")
                    .font(.system(size: 32))
                    .foregroundColor(.gray)
                
                Text("No Poster")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
    }
} 
