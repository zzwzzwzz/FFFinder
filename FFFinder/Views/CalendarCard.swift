//
//  CalendarCard.swift
//  FFFinder
//
//  Created by Micaela Dela Cruz on 13/5/2025.
//

import SwiftUI

struct CalendarCard: View {
    let festival: FilmFestival
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(festival.name)
                .font(.headline)
                .foregroundColor(.primary)
            
            Text("\(formatted(festival.startDate)) - \(formatted(festival.endDate))")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Text(festival.location)
                .font(.subheadline)
                .foregroundColor(.secondary)
            }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
    }
    
    private func formatted(_ date:  Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle =  .medium
        return formatter.string(from: date)
    }
}
