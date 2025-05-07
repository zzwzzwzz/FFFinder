//
//  FestivalDetailView.swift
//  FFFinder
//
//  Created by ZZ on 2025.05.07.
//

import SwiftUI

struct FestivalDetailView: View {
	let festival: FilmFestival
	
	var body: some View {
		ScrollView {
			VStack(alignment: .leading, spacing: 16) {
				Text(festival.name)
					.font(.largeTitle)
					.bold()
				
				Text(festival.dateRange)
					.font(.headline)
				
				Text("Established: \(festival.established)")
					.font(.subheadline)
				
				Text("Location: \(festival.location)")
					.font(.subheadline)
				
				Divider()
				
				Text(festival.description)
					.font(.body)
				
				Link("Visit Website", destination: URL(string: festival.website)!)
					.font(.headline)
					.padding(.top)
			}
			.padding()
		}
		.navigationTitle("Festival Details")
		.navigationBarTitleDisplayMode(.inline)
	}
}

#Preview {
	FestivalDetailView(festival: FilmFestival.samples[0])
}
