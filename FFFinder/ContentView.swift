//
//  ContentView.swift
//  FFFinder
//
//  Created by ZZ on 2025.05.06.
//

import SwiftUI

struct ContentView: View {
	@StateObject private var viewModel = FestivalsViewModel()
	
	var body: some View {
		NavigationStack {
			List(viewModel.festivals) { festival in
				NavigationLink(destination: FestivalDetailView(festival: festival)) {
					VStack(alignment: .leading) {
						Text(festival.name)
							.font(.headline)
						Text(festival.dateRange)
							.font(.subheadline)
							.foregroundColor(.secondary)
					}
				}
			}
			.navigationTitle("Sydney Film Festivals")
		}
	}
}

#Preview {
    ContentView()
}
