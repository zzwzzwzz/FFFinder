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
    @State private var selectedTab: Int
    
    init(viewModel: FestivalsViewModel, initialTab: Int = 0) {
        self.viewModel = viewModel
        _selectedTab = State(initialValue: initialTab)
    }
    
    enum SortOption: String, CaseIterable {
        case popularity = "Popularity"
        case name = "Name"
        case date = "Date"
    }
    
    var genres: [String] {
        if selectedTab == 0 {
            return Array(Set(viewModel.festivals.flatMap { $0.genres })).sorted()
        } else {
            return [] // No genres for films
        }
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
        
        // Apply sorting based on selected sort option
        switch sortOption {
        case .name:
            result.sort { $0.name < $1.name }
        case .date:
            result.sort { $0.startDate < $1.startDate }
        case .popularity:
            result.sort { $0.established < $1.established }
        }
        
        return result
    }
    
    var filteredFilms: [Film] {
        var result = viewModel.festivals.flatMap { $0.featuredFilms }
        
        // Apply search filter
        if !searchText.isEmpty {
            result = result.filter { film in
                film.title.localizedCaseInsensitiveContains(searchText) ||
                film.director.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        // Apply sorting based on selected sort option
        switch sortOption {
        case .name:
            result.sort { $0.title < $1.title }
        case .date:
            result.sort { $0.year > $1.year }
        case .popularity:
            result.sort { $0.awards.count > $1.awards.count }
        }
        
        return result
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Tab Selector
                HStack(spacing: 0) {
                    TabButton(title: "Festivals", isSelected: selectedTab == 0) {
                        selectedTab = 0
                    }
                    
                    TabButton(title: "Films", isSelected: selectedTab == 1) {
                        selectedTab = 1
                    }
                }
                .padding(.horizontal)
                .padding(.top, 8)
                .padding(.bottom, 8)
                
                // Search Bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(AppColors.main)
                    TextField(selectedTab == 0 ? "Search festivals" : "Search films", text: $searchText)
                        .font(.body)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                    
                    if !searchText.isEmpty {
                        Button {
                            searchText = ""
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(AppColors.main)
                        }
                    }
                }
                .padding(10)
                .background(AppColors.background)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(AppColors.main.opacity(0.3), lineWidth: 1)
                )
                .padding(.horizontal)
                .padding(.bottom, 8)
                
                // Content Grid
                ScrollView {
                    LazyVGrid(columns: [
                        GridItem(.flexible(), spacing: 16),
                        GridItem(.flexible(), spacing: 16)
                    ], spacing: 16) {
                        if selectedTab == 0 {
                            ForEach(filteredFestivals) { festival in
                                NavigationLink(destination: FestivalDetailView(festival: festival, viewModel: viewModel)) {
                                    FestivalGridItem(festival: festival)
                                }
                            }
                        } else {
                            ForEach(filteredFilms) { film in
                                NavigationLink(destination: FilmDetailView(film: film, viewModel: viewModel)) {
                                    FilmGridItem(film: film, viewModel: viewModel)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)
                }
            }
            .navigationTitle(selectedTab == 0 ? "All Festivals" : "All Films")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showFilter = true
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                            .foregroundColor(AppColors.main)
                    }
                }
            }
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
                if let imageURL = festival.imageURL {
                    Image(imageURL)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .frame(height: 160)
                        .background(Color("CardBackground"))
                        .cornerRadius(12)
                } else {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 160)
                        .cornerRadius(12)
                        .overlay(
                            Image(systemName: "film")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40)
                                .foregroundColor(.gray)
                        )
                }
                
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
