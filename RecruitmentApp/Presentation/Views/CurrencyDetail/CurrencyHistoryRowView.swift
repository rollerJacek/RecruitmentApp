//
//  CurrencyHistoryRowView.swift
//  RecruitmentApp
//
//  Created by Jacek Stąporek on 08/09/2025.
//

import SwiftUI

struct CurrencyHistoryRowView: View {
    let rate: ExchangeRate
    let code: String
    let shouldHighlight: Bool
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 6) {
                Text(rate.effectiveDate, style: .date)
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                    .accessibilityLabel("Data: \(rate.effectiveDate.nbpFormatted)")
                
                Text("Nr tabeli: \(rate.tableNo)")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .accessibilityLabel("Numer tabeli \(rate.tableNo)")
            }
            
            Spacer(minLength: 16)
            
            VStack(alignment: .trailing, spacing: 4) {
                HStack(spacing: 4) {
                    if shouldHighlight {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.caption)
                            .foregroundColor(.red)
                            .accessibilityLabel("Ostrzeżenie o dużej różnicy kursu")
                    }
                    
                    Text("\(String(format: "%.4f", rate.mid)) \(code)")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(shouldHighlight ? .red : .primary)
                        .accessibilityLabel("Kurs \(String(format: "%.4f", rate.mid)) \(code)")
                }
                
                if shouldHighlight {
                    HStack(spacing: 4) {
                        Image(systemName: "arrow.up.right")
                            .font(.caption2)
                            .foregroundColor(.red)
                            .accessibilityHidden(true)
                        
                        Text("Różnica > 10%")
                            .font(.caption2)
                            .foregroundColor(.red)
                            .fontWeight(.medium)
                            .accessibilityLabel("Różnica większa niż 10 procent")
                    }
                }
            }
        }
        .padding(.vertical, dynamicTypeSize.isAccessibilitySize ? 16 : 12)
        .padding(.horizontal, 12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(shouldHighlight ?
                    Color.red.opacity(colorScheme == .dark ? 0.15 : 0.08) :
                    Color.clear
                )
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(
                    shouldHighlight ?
                        Color.red.opacity(0.4) :
                        Color.clear,
                    lineWidth: shouldHighlight ? 2 : 0
                )
        )
        .accessibilityElement(children: .combine)
        .accessibilityAddTraits(shouldHighlight ? .isSelected : [])
    }
}
