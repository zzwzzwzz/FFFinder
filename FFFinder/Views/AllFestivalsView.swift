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
    @State private var sortOption: SortOption = .popularity  // Default to popularity sorting in UI
    @State private var showFilter = false
    @State private var selectedTab: Int
    @State private var isSearching = false
    @State private var hasInvalidSearch = false
    @State private var showSearchTips = false
    
    // Constants for validation
    private let minSearchLength = 2
    private let searchDebounceTime = 0.5
    
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
        
        // Apply search filter if valid
        if !searchText.isEmpty && !hasInvalidSearch && searchText.count >= minSearchLength {
            result = result.filter { festival in
                festival.name.localizedCaseInsensitiveContains(searchText) ||
                festival.description.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        // Apply genre filter
        if let selectedGenre = selectedGenre {
            result = result.filter { $0.genres.contains(selectedGenre) }
        }
        
        // Sort by selected option
        switch sortOption {
        case .name:
            result.sort { $0.name < $1.name }
        case .date:
            result.sort { $0.startDate < $1.startDate }
        case .popularity:
            // Sort by number of featured films (or another popularity metric)
            result.sort { $0.featuredFilms.count > $1.featuredFilms.count }
        }
        
        return result
    }
    
    var filteredFilms: [Film] {
        var result = viewModel.festivals.flatMap { $0.featuredFilms }
        
        // Apply search filter if valid
        if !searchText.isEmpty && !hasInvalidSearch && searchText.count >= minSearchLength {
            result = result.filter { film in
                film.title.localizedCaseInsensitiveContains(searchText) ||
                film.director.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        // Sort by selected option
        switch sortOption {
        case .popularity:
            result.sort { $0.awards.count > $1.awards.count }
        case .name:
            result.sort { $0.title < $1.title }
        case .date:
            result.sort { $0.year > $1.year } // Most recent first
        }
        
        return result
    }
    
    // Check if search contains invalid characters
    private func validateSearch(_ text: String) -> Bool {
        // Simple validation to avoid SQL injection or excessive special characters
        let invalidChars = CharacterSet(charactersIn: ";\\/`'\"<>")
        return text.rangeOfCharacter(from: invalidChars) == nil
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
                .padding(.bottom, 16)
                
                // Content Grid
                ScrollView {
                    // Search Bar with validation
                    VStack(spacing: 6) {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(AppColors.main)
                            TextField(selectedTab == 0 ? "Search festivals" : "Search films", text: $searchText)
                                .font(.body)
                                .autocorrectionDisabled()
                                .textInputAutocapitalization(.never)
                                .onChange(of: searchText) { oldValue, newValue in
                                    // Validate search
                                    hasInvalidSearch = !validateSearch(newValue)
                                    isSearching = true
                                    
                                    // Show search tips if needed
                                    showSearchTips = newValue.count > 0 && newValue.count < minSearchLength
                                    
                                    // Debounce search to improve performance
                                    DispatchQueue.main.asyncAfter(deadline: .now() + searchDebounceTime) {
                                        if searchText == newValue {
                                            isSearching = false
                                        }
                                    }
                                }
                            
                            if !searchText.isEmpty {
                                Button {
                                    searchText = ""
                                    hasInvalidSearch = false
                                    showSearchTips = false
                                    isSearching = false
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
                                .stroke(hasInvalidSearch ? Color.red : AppColors.main.opacity(0.3), lineWidth: 1)
                        )
                        
                        // Error messages
                        if hasInvalidSearch {
                            Text("Please avoid special characters")
                                .font(.caption)
                                .foregroundColor(.red)
                        } else if showSearchTips {
                            Text("Type at least \(minSearchLength) characters to search")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                    
                    // Filter information
                    if selectedGenre != nil {
                        HStack {
                            Text("Filtered by: \(selectedGenre!)")
                                .font(.caption)
                                .foregroundColor(AppColors.main)
                            
                            Button {
                                selectedGenre = nil
                            } label: {
                                Text("Clear")
                                    .font(.caption)
                                    .foregroundColor(.red)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 8)
                    }
                    
                    // Loading indicator
                    if isSearching {
                        VStack {
                            ProgressView()
                                .padding()
                            Text("Searching...")
                                .foregroundColor(.secondary)
                        }
                        .frame(maxWidth: .infinity, minHeight: 200)
                    }
                    // Search results
                    else if !isSearching {
                        if (selectedTab == 0 && filteredFestivals.isEmpty) || 
                           (selectedTab == 1 && filteredFilms.isEmpty) {
                            VStack(spacing: 8) {
                                Image(systemName: selectedTab == 0 ? "film.stack" : "film")
                                    .font(.system(size: 50))
                                    .foregroundColor(.gray)
                                    .padding()
                                
                                Text("No \(selectedTab == 0 ? "festivals" : "films") found")
                                    .font(.headline)
                                    .foregroundColor(.gray)
                                
                                if hasInvalidSearch {
                                    Text("Please try a different search term")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                } else if selectedGenre != nil {
                                    Text("Try clearing the genre filter")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                            }
                            .frame(maxWidth: .infinity, minHeight: 200)
                            .padding()
                        } else {
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
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(selectedTab == 0 ? "All Festivals" : "All Films")
                        .font(.system(.title, weight: .bold))
                        .foregroundColor(AppColors.main)
                }
                
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
