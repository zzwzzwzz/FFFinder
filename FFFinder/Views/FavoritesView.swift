//
//  FavoritesView.swift
//  FFFinder
//
//  Created by ZZ on 2025.05.07.
//

import SwiftUI

struct FavoritesView: View {
	@ObservedObject var viewModel: FestivalsViewModel
	
	var body: some View {
		NavigationStack {
			ZStack {
				Color("BackgroundColor")
					.edgesIgnoringSafeArea(.all)
				
				VStack {
					Text("Your Favorites")
						.font(.title)
						.fontWeight(.bold)
						.frame(maxWidth: .infinity, alignment: .leading)
						.padding()
					
					if viewModel.favoriteIds.isEmpty {
						VStack(spacing: 20) {
							Spacer()
							Image(systemName: "heart.fill")
								.font(.system(size: 60))
								.foregroundColor(AppColors.main)
							Text("No favorites yet")
								.font(.title2)
								.foregroundColor(AppColors.main)
							Text("Tap the heart icon on a festival to add it to your favorites")
								.font(.body)
								.foregroundColor(AppColors.main)
								.multilineTextAlignment(.center)
								.padding(.horizontal, 40)
							Spacer()
						}
					} else {
						List {
							ForEach(viewModel.getFavoriteFestivals()) { festival in
								NavigationLink(destination: FestivalDetailView(festival: festival, viewModel: viewModel)) {
									FestivalListItem(festival: festival)
								}
								.listRowBackground(Color("CardBackground"))
							}
						}
						.listStyle(.plain)
					}
				}
			}
			.navigationBarHidden(true)
		}
	}
}

#Preview {
	FavoritesView(viewModel: FestivalsViewModel())
}
