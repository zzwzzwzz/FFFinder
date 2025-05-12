//
//  HelpSupportView.swift
//  FFFinder
//
//  Created by APPLE on 2025/5/11.
//

import SwiftUI

struct HelpSupportView: View {
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            ScrollView {
                VStack(spacing: 28) {
                    // Title
                    Text("Help & Support")
                        .font(.largeTitle.bold())
                        .foregroundColor(AppColors.main)
						.frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 24)
						.padding(.leading, 24)

                    // FAQ Card
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Frequently Asked Questions")
                            .font(.title2.bold())
                            .foregroundColor(AppColors.main)
                        ForEach(faqList, id: \.question) { item in
                            FAQItem(question: item.question, answer: item.answer)
                        }
                    }
                    .padding(20)
                    .background(Color.white)
                    .cornerRadius(16)
                    .shadow(color: .black.opacity(0.08), radius: 10, x: 0, y: 4)
                    .frame(maxWidth: 500)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.horizontal)

                    // Contact Card
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Contact Us")
                            .font(.title2.bold())
                            .foregroundColor(AppColors.main)
                        Text("If you have any issues, feedback, or questions, feel free to reach out:")
                            .font(.body)
                        HStack(spacing: 8) {
                            Image(systemName: "envelope")
                                .foregroundColor(AppColors.main)
                            Text("ziwenzhou.zz@gmail.com")
                                .font(.body)
                                .foregroundColor(.primary)
                        }
                    }
                    .padding(20)
                    .background(Color.white)
                    .cornerRadius(16)
                    .shadow(color: .black.opacity(0.08), radius: 10, x: 0, y: 4)
                    .frame(width: 400)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.horizontal)

                    Spacer(minLength: 50)
					Spacer()
					Text("© 2025 FFFinder. All rights reserved.")
						.font(.footnote)
						.foregroundColor(.secondary)
						.frame(maxWidth: .infinity)
						.padding(.bottom, 40)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        HelpSupportView()
    }
}
