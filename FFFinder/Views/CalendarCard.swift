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
        HStack(spacing: 16) {
            // Festival logo/image
            if let imageName = festival.imageURL {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 50, height: 50)
                    .cornerRadius(12)
                    .overlay(
                        Image(systemName: "film")
                            .foregroundColor(.gray)
                    )
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(festival.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text("\(formatted(festival.startDate)) - \(formatted(festival.endDate))")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text(festival.location)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
    }
    
    private func formatted(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}
