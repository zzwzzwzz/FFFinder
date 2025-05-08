import SwiftUI

struct AllFestivalsView: View {
    @ObservedObject var viewModel: FestivalsViewModel
    @State private var searchText = ""
    @State private var selectedGenre: String?
    @State private var sortOption: SortOption = .name
    @State private var showFilters = false
    @Environment(\.dismiss) private var dismiss
    
    enum SortOption: String, CaseIterable {
        case name = "Name"
        case date = "Date"
        case popularity = "Popularity"
    }
    
    var genres: [String] {
        viewModel.getAvailableGenres()
    }
    
    var filteredFestivals: [FilmFestival] {
        var festivals = viewModel.festivals
        
        if !searchText.isEmpty {
            festivals = festivals.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
        
        if let genre = selectedGenre {
            festivals = festivals.filter { $0.genres.contains(genre) }
        }
        
        // Sort festivals
        switch sortOption {
        case .name:
            festivals.sort { $0.name < $1.name }
        case .date:
            festivals.sort { $0.dateRange < $1.dateRange }
        case .popularity:
            // For now, we'll use establishment year as a proxy for popularity
            festivals.sort { $0.established > $1.established }
        }
        
        return festivals
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor")
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 0) {
                    // Header with back button and filter
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
                                .foregroundColor(AppColors.primary)
                                .font(.title3)
                        }
                        
                        Text("All Film Festivals")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        Button {
                            showFilters = true
                        } label: {
                            Image(systemName: "line.3.horizontal.decrease.circle")
                                .foregroundColor(AppColors.primary)
                                .font(.title3)
                        }
                    }
                    .padding()
                    
                    // Search field
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(AppColors.primary)
                        TextField("Search festivals", text: $searchText)
                            .font(.body)
                        
                        if !searchText.isEmpty {
                            Button {
                                searchText = ""
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(AppColors.primary)
                            }
                        }
                    }
                    .padding(10)
                    .background(AppColors.background)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(AppColors.primary.opacity(0.3), lineWidth: 1)
                    )
                    .padding(.horizontal)
                    
                    // Active filters
                    if selectedGenre != nil {
                        HStack {
                            Text("Active Filters:")
                                .foregroundColor(.secondary)
                            Text(selectedGenre ?? "")
                                .foregroundColor(AppColors.primary)
                            Button {
                                selectedGenre = nil
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(AppColors.primary)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 8)
                    }
                    
                    // Results
                    if filteredFestivals.isEmpty {
                        VStack {
                            Spacer()
                            Image(systemName: "film.stack")
                                .font(.system(size: 60))
                                .foregroundColor(AppColors.primary)
                            Text("No festivals found")
                                .font(.title2)
                                .foregroundColor(AppColors.primary)
                                .padding(.top)
                            Spacer()
                        }
                    } else {
                        ScrollView {
                            LazyVGrid(columns: [
                                GridItem(.flexible(), spacing: 16),
                                GridItem(.flexible(), spacing: 16)
                            ], spacing: 16) {
                                ForEach(filteredFestivals) { festival in
                                    NavigationLink(destination: FestivalDetailView(festival: festival, viewModel: viewModel)) {
                                        FestivalGridItem(festival: festival)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                            .padding()
                        }
                    }
                }
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $showFilters) {
                FilterView(
                    isPresented: $showFilters,
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
                                .background(AppColors.primary.opacity(0.1))
                                .foregroundColor(AppColors.primary)
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