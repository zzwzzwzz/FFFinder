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
        NavigationView {
            VStack(spacing: 0) {
                // Sort options
                VStack(alignment: .leading, spacing: 16) {
                    Text("Sort By")
                        .font(.headline)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                        .padding(.top)
                    
                    ForEach(AllFestivalsView.SortOption.allCases, id: \.self) { option in
                        Button(action: {
                            sortOption = option
                        }) {
                            HStack {
                                Text(option.rawValue)
                                    .foregroundColor(.primary)
                                Spacer()
                                if sortOption == option {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(AppColors.main)
                                } else {
                                    Image(systemName: "circle")
                                        .foregroundColor(.gray.opacity(0.3))
                                }
                            }
                            .padding(.vertical, 12)
                            .padding(.horizontal)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(sortOption == option ? AppColors.main.opacity(0.1) : Color.clear)
                            )
                        }
                        .padding(.horizontal)
                    }
                }
                
                Divider()
                    .padding(.vertical)
                
                // Genre filters
                VStack(alignment: .leading, spacing: 16) {
                    Text("Genres")
                        .font(.headline)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                    
                    ScrollView {
                        VStack(spacing: 8) {
                            Button(action: {
                                selectedGenre = nil
                            }) {
                                HStack {
                                    Text("All Genres")
                                        .foregroundColor(.primary)
                                    Spacer()
                                    if selectedGenre == nil {
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundColor(AppColors.main)
                                    } else {
                                        Image(systemName: "circle")
                                            .foregroundColor(.gray.opacity(0.3))
                                    }
                                }
                                .padding(.vertical, 12)
                                .padding(.horizontal)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(selectedGenre == nil ? AppColors.main.opacity(0.1) : Color.clear)
                                )
                            }
                            .padding(.horizontal)
                            
                            ForEach(genres, id: \.self) { genre in
                                Button(action: {
                                    selectedGenre = genre
                                }) {
                                    HStack {
                                        Text(genre)
                                            .foregroundColor(.primary)
                                        Spacer()
                                        if selectedGenre == genre {
                                            Image(systemName: "checkmark.circle.fill")
                                                .foregroundColor(AppColors.main)
                                        } else {
                                            Image(systemName: "circle")
                                                .foregroundColor(.gray.opacity(0.3))
                                        }
                                    }
                                    .padding(.vertical, 12)
                                    .padding(.horizontal)
                                    .background(
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(selectedGenre == genre ? AppColors.main.opacity(0.1) : Color.clear)
                                    )
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                    .frame(maxHeight: 300)
                }
                
                Spacer()
                
                // Bottom buttons
                VStack(spacing: 12) {
                    Button {
                        selectedGenre = nil
                        sortOption = .name
                    } label: {
                        Text("Clear All Filters")
                            .font(.headline)
                            .foregroundColor(AppColors.main)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(AppColors.main, lineWidth: 1)
                            )
                    }
                    
                    Button {
                        isPresented = false
                    } label: {
                        Text("Apply Filters")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(AppColors.main)
                            .cornerRadius(12)
                    }
                }
                .padding()
            }
            .navigationTitle("Filters")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isPresented = false
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(AppColors.main)
                            .font(.title3)
                    }
                }
            }
        }
    }
}
