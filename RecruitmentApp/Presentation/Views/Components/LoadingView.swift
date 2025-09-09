//
//  LoadingView.swift
//  RecruitmentApp
//
//  Created by Jacek Stąporek on 08/09/2025.
//

import SwiftUI

struct LoadingView: View {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    
    var body: some View {
        VStack(spacing: 20) {
            if reduceMotion {
                Image(systemName: "arrow.clockwise")
                    .font(.system(size: dynamicTypeSize.isAccessibilitySize ? 60 : 40))
                    .foregroundColor(.blue)
                    .accessibilityLabel("Ładowanie")
            } else {
                ProgressView()
                    .scaleEffect(dynamicTypeSize.isAccessibilitySize ? 2.0 : 1.5)
                    .accessibilityLabel("Ładowanie")
            }
            
            Text("Ładowanie kursów walut...")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .accessibilityLabel("Pobieranie aktualnych kursów walut z Narodowego Banku Polskiego")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .accessibilityElement(children: .combine)
    }
}
