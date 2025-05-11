//
//  HelpSupportView.swift
//  FFFinder
//
//  Created by APPLE on 2025/5/11.
//

import SwiftUI

struct HelpSupportView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                
                Text("Help & Support")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Frequently Asked Questions")
                    .font(.title2.bold())
                    .padding(.bottom, 4)


                ForEach(faqList, id: \.question) { item in
                    FAQItem(question: item.question, answer: item.answer)
                }

                Divider()

                Text("Contact Us")
                    .font(.title2.bold())

                Text("If you have any issues, feedback, or questions, feel free to reach out to us:")
                    .font(.body)

                HStack {
                    Image(systemName: "envelope")
                    Text("support@cinephiles.app")
                        .foregroundColor(.blue)
                }

                Spacer(minLength: 20)
            }
            .padding()
        }
    }
}

#Preview {
    NavigationStack {
        HelpSupportView()
    }
}
