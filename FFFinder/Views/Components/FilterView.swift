//
//  FilterView.swift
//  FFFinder
//
//  Created by ZZ on 2025.05.07.
//

import SwiftUI

struct FilterView: View {
    @Binding var isPresented: Bool
    @Binding var selectedGenre: String?
    @Binding var sortOption: AllFestivalsView.SortOption
    let genres: [String]
    
    var body: some View {
        VStack(spacing: 20) {
            // Header
            HStack {
                Text("Filters")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Spacer()
                
                Button {
                    isPresented = false
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(AppColors.main)
                        .font(.title2)
                }
            }
            .padding(.horizontal)
            
            // Sort options
            VStack(alignment: .leading, spacing: 12) {
                Text("Sort By")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                ForEach(AllFestivalsView.SortOption.allCases, id: \.self) { option in
                    Button(action: {
                        sortOption = option
                    }) {
                        HStack {
                            Text(option.rawValue)
                            Spacer()
                            if sortOption == option {
                                Image(systemName: "checkmark")
                                    .foregroundColor(AppColors.main)
                            }
                        }
                        .padding(.vertical, 8)
                    }
                    .foregroundColor(.primary)
                }
            }
            .padding(.horizontal)
            
            // Genre filters
            VStack(alignment: .leading, spacing: 12) {
                Text("Genres")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 8) {
                        Button(action: {
                            selectedGenre = nil
                        }) {
                            HStack {
                                Text("All Genres")
                                Spacer()
                                if selectedGenre == nil {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(AppColors.main)
                                }
                            }
                            .padding(.vertical, 8)
                        }
                        .foregroundColor(.primary)
                        
                        ForEach(genres, id: \.self) { genre in
                            Button(action: {
                                selectedGenre = genre
                            }) {
                                HStack {
                                    Text(genre)
                                    Spacer()
                                    if selectedGenre == genre {
                                        Image(systemName: "checkmark")
                                            .foregroundColor(AppColors.main)
                                    }
                                }
                                .padding(.vertical, 8)
                            }
                            .foregroundColor(.primary)
                        }
                    }
                }
                .frame(maxHeight: 200)
            }
            .padding(.horizontal)
            
            // Apply button
            Button {
                isPresented = false
            } label: {
                Text("Apply Filters")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(AppColors.main)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            .padding(.top)
        }
        .padding(.vertical)
        .background(Color("CardBackground"))
        .cornerRadius(20)
        .shadow(radius: 10)
        .padding()
    }
}
