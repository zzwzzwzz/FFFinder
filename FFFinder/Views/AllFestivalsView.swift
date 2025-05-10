//
//  AllFestivalsView.swift
//  FFFinder
//
//  Created by ZZ on 2025.05.07.
//

import SwiftUI

struct AllFestivalsView: View {
    @ObservedObject var viewModel: FestivalsViewModel
    @State private var searchText = ""
    @State private var selectedGenre: String?
    @State private var sortOption: SortOption = .name
    @State private var showFilter = false
    @Environment(\.dismiss) private var dismiss
    
    enum SortOption: String, CaseIterable {
        case name = "Name"
        case date = "Date"
        case popularity = "Popularity"
    }
    
    var genres: [String] {
        Array(Set(viewModel.festivals.flatMap { $0.genres })).sorted()
    }
    
    var filteredFestivals: [FilmFestival] {
        var result = viewModel.festivals
        
        // Apply search filter
        if !searchText.isEmpty {
            result = result.filter { festival in
                festival.name.localizedCaseInsensitiveContains(searchText) ||
                festival.description.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        // Apply genre filter
        if let selectedGenre = selectedGenre {
            result = result.filter { $0.genres.contains(selectedGenre) }
        }
        
        // Apply sorting
        switch sortOption {
        case .name:
            result.sort { $0.name < $1.name }
        case .date:
            result.sort { $0.dateRange < $1.dateRange }
        case .popularity:
            result.sort { $0.established < $1.established }
        }
        
        return result
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Search Header
                VStack(spacing: 12) {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        
                        TextField("Search festivals...", text: $searchText)
                            .textFieldStyle(PlainTextFieldStyle())
                    }
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    
                    // Filter Button
                    Button {
                        showFilter = true
                    } label: {
                        HStack {
                            Image(systemName: "line.3.horizontal.decrease.circle")
                            Text("Filter")
                        }
                        .foregroundColor(AppColors.main)
                    }
                }
                .padding()
                .background(AppColors.background)
                
                // Festival Grid
                ScrollView {
                    LazyVGrid(columns: [
                        GridItem(.flexible(), spacing: 16),
                        GridItem(.flexible(), spacing: 16)
                    ], spacing: 16) {
                        ForEach(filteredFestivals) { festival in
                            NavigationLink(destination: FestivalDetailView(festival: festival, viewModel: viewModel)) {
                                FestivalGridItem(festival: festival)
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("All Festivals")
            .sheet(isPresented: $showFilter) {
                FilterView(
                    isPresented: $showFilter,
                    selectedGenre: $selectedGenre,
                    sortOption: $sortOption,
                    genres: genres
                )
            }
        }
    }
}

struct FestivalGridItem: View {
    let festival: FilmFestival
    
    var body: some View {
        VStack(alignment: .leading) {
            // Festival image
            ZStack(alignment: .bottomLeading) {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .aspectRatio(1, contentMode: .fit)
                    .overlay(
                        Image(systemName: "film")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40)
                            .foregroundColor(.gray)
                    )
                
                // Date badge
                Text(festival.dateRange)
                    .font(.caption)
                    .padding(6)
                    .background(Color.black.opacity(0.7))
                    .foregroundColor(.white)
                    .cornerRadius(4)
                    .padding(8)
            }
            
            // Festival info
            VStack(alignment: .leading, spacing: 4) {
                Text(festival.name)
                    .font(.headline)
                    .lineLimit(1)
                
                Text(festival.location)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                
                // Genres
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 4) {
                        ForEach(festival.genres, id: \.self) { genre in
                            Text(genre)
                                .font(.caption2)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(AppColors.main.opacity(0.1))
                                .foregroundColor(AppColors.main)
                                .cornerRadius(4)
                        }
                    }
                }
            }
            .padding(8)
        }
        .background(Color("CardBackground"))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}

#Preview {
    AllFestivalsView(viewModel: FestivalsViewModel())
}
