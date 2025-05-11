//
//  FAQ.swift
//  FFFinder
//
//  Created by APPLE on 2025/5/11.
//

import SwiftUI

struct FAQItem: View {
    let question: String
    let answer: String
    @State private var isExpanded = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Button(action: {
                withAnimation {
                    isExpanded.toggle()
                }
            }) {
                HStack {
                    Text("Q: \(question)")
                        .font(.headline)
                        .foregroundColor(AppColors.main)
                        .multilineTextAlignment(.leading)

                    Spacer()

                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(.gray)
                }
            }

            if isExpanded {
                Text("A: \(answer)")
                    .font(.subheadline)
                    .transition(.opacity)
            }

            Divider()
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    FAQItem(question: "How do I add a festival to Favorites?",
            answer: "Tap the heart icon on the festival detail page.")
}
