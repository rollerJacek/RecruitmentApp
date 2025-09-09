//
//  ErrorView.swift
//  RecruitmentApp
//
//  Created by Jacek Stąporek on 08/09/2025.
//

import SwiftUI

struct ErrorView: View {
    let message: String
    let retryAction: () -> Void
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    
    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: dynamicTypeSize.isAccessibilitySize ? 72 : 50))
                .foregroundColor(.orange)
                .accessibilityHidden(true)
            
            VStack(spacing: 12) {
                Text("Wystąpił błąd")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                    .accessibilityAddTraits(.isHeader)
                
                Text(message)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .lineLimit(dynamicTypeSize.isAccessibilitySize ? nil : 4)
                    .padding(.horizontal, 16)
            }
            
            Button(action: retryAction) {
                HStack(spacing: 8) {
                    Image(systemName: "arrow.clockwise")
                        .font(.system(size: 16, weight: .medium))
                        .accessibilityHidden(true)
                    
                    Text("Spróbuj ponownie")
                        .font(.headline)
                        .fontWeight(.medium)
                }
                .foregroundColor(.white)
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.blue)
                )
            }
            .accessibilityLabel("Spróbuj ponownie załadować kursy walut")
            .accessibilityHint("Dotknij aby ponownie pobrać dane")
            .accessibilityAddTraits(.isButton)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(24)
        .accessibilityElement(children: .contain)
    }
}
