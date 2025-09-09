//
//  CurrencyRowView.swift
//  RecruitmentApp
//
//  Created by Jacek Stąporek on 08/09/2025.
//

import SwiftUI

struct CurrencyRowView: View {
    let currency: Currency
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 6) {
                Text(currency.code)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                    .accessibilityLabel("Kod waluty \(currency.code)")
                
                Text(currency.name)
                    .font(.subheadline)
                    .foregroundColor(.primary)
                    .lineLimit(dynamicTypeSize.isAccessibilitySize ? nil : 2)
                    .multilineTextAlignment(.leading)
                    .accessibilityLabel("Nazwa: \(currency.name)")
                
                HStack(spacing: 8) {
                    Text("Tabela \(currency.tableType.rawValue)")
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(
                            RoundedRectangle(cornerRadius: 6)
                                .fill(Color.secondary.opacity(0.2))
                                .stroke(Color.secondary.opacity(0.4), lineWidth: 1)
                        )
                        .accessibilityLabel("Tabela typu \(currency.tableType.rawValue)")
                    
                    Text(currency.tableNo)
                        .font(.caption2)
                        .foregroundColor(.secondary)
                        .accessibilityLabel("Numer tabeli \(currency.tableNo)")
                }
            }
            
            Spacer(minLength: 16)
            
            VStack(alignment: .trailing, spacing: 6) {
                Text("\(String(format: "%.4f", currency.currentRate)) \(currency.code)")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.trailing)
                    .accessibilityLabel("Kurs \(String(format: "%.4f", currency.currentRate)) \(currency.name)")
                
                Text(currency.effectiveDate, style: .date)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .accessibilityLabel("Data: \(currency.effectiveDate.nbpFormatted)")
            }
        }
        .padding(.vertical, dynamicTypeSize.isAccessibilitySize ? 12 : 8)
        .padding(.horizontal, 4)
        .background(Color(.systemBackground))
        .contentShape(Rectangle())
        .accessibilityElement(children: .combine)
        .accessibilityAddTraits(.isButton)
    }
}
