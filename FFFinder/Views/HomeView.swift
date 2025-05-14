//
//  HomeView.swift
//  FFFinder
//
//  Created by ZZ on 2025.05.07.
//

import SwiftUI

struct HomeView: View {
	@ObservedObject var viewModel: FestivalsViewModel
	@State private var showSearch = false
    @State private  var selectedDate = Date()
    @State private var isDateOutOfRange = false
    
    var matchingFestivals: [FilmFestival] {
        viewModel.festivals.filter {
            $0.startDate <= selectedDate && $0.endDate >= selectedDate
        }
    }
	
	var featuredFestivals: [FilmFestival] {
		// Only use all festivals, no searchText
		let festivalsToConsider = viewModel.festivals
		// Get current date
		let today = Date()
		// Filter for festivals that start on or after today, and sort by start date
		return festivalsToConsider
			.filter { $0.startDate >= today }
			.sorted { $0.startDate < $1.startDate }
			.prefix(4)
			.map { $0 }
	}
	
	var featuredFilms: [Film] {
		// Get all films from all festivals and sort by number of awards (popularity)
		let allFilms = viewModel.festivals.flatMap { $0.featuredFilms }
		return allFilms.sorted { $0.awards.count > $1.awards.count }
	}
	
	var filteredFestivals: [FilmFestival] {
		let festivals = viewModel.festivals
		// Only show festivals that start on or after today
		let today = Date()
		return festivals
			.filter { $0.startDate >= today }
			.sorted { $0.startDate < $1.startDate }
	}
	
	var body: some View {
		NavigationStack {
			ZStack {
				// Background
				Color("BackgroundColor")
					.edgesIgnoringSafeArea(.all)
				
                ScrollViewReader { proxy in
                    ScrollView {
                        VStack {
                            // Header
                            HStack {
                                // App logo
                                ZStack {
                                    Circle()
                                        .fill(AppColors.main.opacity(0.15))
                                        .frame(width: 44, height: 44)
                                    Image("AppLogo")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 40, height: 40)
                                        .clipShape(Circle())
                                }
                                .overlay(
                                    Circle()
                                        .stroke(AppColors.main, lineWidth: 2)
                                        .frame(width: 44, height: 44)
                                )
                                
                                Text("FFFinder")
                                    .font(.title)
                                    .bold(true)
                                    .foregroundColor(AppColors.main)
                                
                                Spacer()
                                
                                Button(action: { showSearch = true }) {
                                    Image(systemName: "magnifyingglass")
                                        .font(.title2)
                                        .foregroundColor(AppColors.main)
                                        .padding(10)
                                        .background(AppColors.background)
                                        .clipShape(Circle())
                                }
                            }
                            .padding(.horizontal)
                            .padding(.top, 8)
                            
                            // Featured festivals section
                            VStack(alignment: .leading) {
                                Text("Upcoming Festivals")
                                    .font(.headline)
                                    .padding(.horizontal)
                                    .padding(.top, 5)
                                    .foregroundColor(AppColors.main)
                                
                                if featuredFestivals.isEmpty {
                                    VStack(alignment: .center) {
                                        Text("No upcoming festivals found")
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                            .padding()
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical)
                                } else {
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack(spacing: 24) {
                                            ForEach(featuredFestivals) { festival in
                                                NavigationLink(destination: FestivalDetailView(festival: festival, viewModel: viewModel)) {
                                                    UpcomingFestivalCard(festival: festival)
                                                }
                                                .buttonStyle(PlainButtonStyle())
                                            }
                                        }
                                        .padding(.horizontal)
                                        .padding(.vertical, 8)
                                    }
                                }
                            }
                            
                            // Featured Films section with More button
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("Featured Films")
                                        .font(.headline)
                                        .foregroundColor(AppColors.main)
                                    
                                    Spacer()
                                    
                                    NavigationLink(destination: AllFestivalsView(viewModel: viewModel, initialTab: 1)) {
                                        Text("More")
                                            .foregroundColor(AppColors.main)
                                            .font(.subheadline)
                                    }
                                }
                                .padding(.horizontal)
                                .padding(.top, 5)
                                .padding(.bottom, 5)
                                
                                ScrollView {
                                    LazyVGrid(columns: [
                                        GridItem(.flexible(), spacing: 16),
                                        GridItem(.flexible(), spacing: 16)
                                    ], spacing: 16) {
                                        ForEach(featuredFilms.prefix(4)) { film in
                                            NavigationLink(destination: FilmDetailView(film: film, viewModel: viewModel)) {
                                                FilmGridItem(film: film, viewModel: viewModel)
                                            }
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                            }
                            .padding(.bottom, 5)
                            
                            VStack(alignment:.leading) {
                                Text("Browse by Date")
                                    .font(.headline)
                                    .padding(.horizontal)
                                    .padding(.top, 10)
                                    .foregroundColor(AppColors.main)
                                
                                VStack(spacing: 8) {
                                    DatePicker("Select a date", selection: $selectedDate, displayedComponents: .date)
                                        .datePickerStyle(GraphicalDatePickerStyle())
                                        .padding(.horizontal)
                                        .onChange(of: selectedDate) { oldValue, newValue in
                                            // Validate date range
                                            validateSelectedDate()
                                        }
                                    
                                    // Date validation message
                                    if isDateOutOfRange {
                                        Text("This date is outside festival date ranges (showing current festivals anyway)")
                                            .font(.caption)
                                            .foregroundColor(.orange)
                                            .padding(.horizontal)
                                    }
                                }
                                
                                if matchingFestivals.isEmpty {
                                    VStack(spacing: 8) {
                                        Text("No festivals on this date.")
                                            .foregroundColor(.secondary)
                                            .padding(.horizontal)
                                        
                                        // Suggest nearest festival
                                        if let nearestFestival = nearestUpcomingFestival {
                                            VStack(alignment: .leading) {
                                                Text("Suggestion:")
                                                    .font(.caption)
                                                    .foregroundColor(.secondary)
                                                    .padding(.horizontal)
                                                
                                                Button(action: {
                                                    withAnimation {
                                                        selectedDate = nearestFestival.startDate
                                                    }
                                                }) {
                                                    HStack {
                                                        Text("Try \(formattedDate(nearestFestival.startDate))")
                                                            .font(.subheadline)
                                                            .foregroundColor(AppColors.main)
                                                        
                                                        Image(systemName: "arrow.right.circle.fill")
                                                            .foregroundColor(AppColors.main)
                                                    }
                                                    .padding(.horizontal)
                                                }
                                            }
                                        }
                                    }
                                    .padding(.bottom, 100)
                                } else {
                                    VStack(spacing: 12) {
                                        ForEach(matchingFestivals) { festival in
                                            NavigationLink(destination: FestivalDetailView(festival: festival, viewModel: viewModel)) {
                                                CalendarCard(festival: festival)
                                            }
                                            .buttonStyle(PlainButtonStyle())
                                        }
                                    }
                                }
                            }
                            .frame(minHeight: 200)
                            .animation(.easeInOut(duration: 0.3), value: matchingFestivals.count)
                        }
                        .id("calendarSection")  // Scroll to Card
                    }
                    .onChange(of: selectedDate) { oldValue, newValue in
                        if !matchingFestivals.isEmpty {
                            withAnimation {
                                proxy.scrollTo("calendarSection", anchor: .bottom)
                            }
                        }
                    }
                }
			}
			.navigationBarHidden(true)
			// Present SearchView when search icon tapped
			.sheet(isPresented: $showSearch) {
				SearchView(viewModel: viewModel)
			}
		}
	}
	
	private func validateSelectedDate() {
		let today = Date()
		let oneYearFromNow = Calendar.current.date(byAdding: .year, value: 1, to: today)!
		let oneYearAgo = Calendar.current.date(byAdding: .year, value: -1, to: today)!
		
		if selectedDate < oneYearAgo || selectedDate > oneYearFromNow {
			isDateOutOfRange = true
		} else {
			isDateOutOfRange = false
		}
	}
	
	private var nearestUpcomingFestival: FilmFestival? {
		let today = Date()
		let upcomingFestivals = viewModel.festivals.filter { $0.startDate >= today }
		return upcomingFestivals.min(by: { $0.startDate < $1.startDate })
	}
	
	private func formattedDate(_ date: Date) -> String {
		let formatter = DateFormatter()
		formatter.dateStyle = .medium
		return formatter.string(from: date)
	}
}

#Preview {
	HomeView(viewModel: FestivalsViewModel())
}
