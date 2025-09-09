//
//  CurrencyDetailView.swift
//  RecruitmentApp
//
//  Created by Jacek Stąporek on 08/09/2025.
//

import SwiftUI

struct CurrencyDetailView: View {
    let currency: Currency
    @State private var viewModel: CurrencyDetailViewModel
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    
    init(currency: Currency) {
        self.currency = currency
        
        let useCase = DIContainer.shared.resolve(FetchCurrencyHistoryUseCaseProtocol.self)
        self.viewModel = CurrencyDetailViewModel(
            currency: currency,
            fetchHistoryUseCase: useCase
        )
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            currencyInfoHeader
                .padding()
                .background(Color(.systemGray6))
                .accessibilityElement(children: .combine)
            
            switch viewModel.viewState {
            case .loading:
                LoadingView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            case .loaded:
                historyList
            case .error(let error):
                ErrorView(message: error.localizedDescription) {
                    viewModel.loadHistory()
                }
            }
        }
        .navigationTitle(currency.code)
        .navigationBarTitleDisplayMode(dynamicTypeSize.isAccessibilitySize ? .large : .inline)
        .onAppear {
            viewModel.loadHistory()
        }
        .accessibilityElement(children: .contain)
    }
    
    private var currencyInfoHeader: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text(currency.code)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .accessibilityAddTraits(.isHeader)
                    .accessibilityLabel("Kod waluty \(currency.code)")
                
                Spacer()
                
                Text("Tabela \(currency.tableType.rawValue)")
                    .font(.caption)
                    .fontWeight(.medium)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.blue.opacity(0.15))
                    .foregroundColor(.blue)
                    .cornerRadius(8)
                    .accessibilityLabel("Tabela typu \(currency.tableType.rawValue)")
            }
            
            Text(currency.name)
                .font(.headline)
                .foregroundColor(.primary)
                .accessibilityLabel("Nazwa waluty: \(currency.name)")
            
            VStack {
                HStack {
                    Text("Aktualny kurs:")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .fontWeight(.medium)
                    
                    Spacer()
                    
                    Text("\(String(format: "%.4f", currency.currentRate)) \(currency.code)")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                        .accessibilityLabel("Aktualny kurs \(String(format: "%.4f", currency.currentRate)) \(currency.name)")
                }
                .padding(.vertical, 4)
                .padding(.horizontal, 8)
                .background(Color(.systemGray5).opacity(0.5))
                .cornerRadius(8)
                
                HStack {
                    Text("Data publikacji:")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .fontWeight(.medium)
                    
                    Spacer()
                    
                    Text(currency.effectiveDate, style: .date)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                        .accessibilityLabel("Data publikacji: \(currency.effectiveDate.nbpFormatted)")
                }
                
                HStack {
                    Text("Numer tabeli:")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .fontWeight(.medium)
                    
                    Spacer()
                    
                    Text(currency.tableNo)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                        .accessibilityLabel("Numer tabeli \(currency.tableNo)")
                }
            }
        }
        .padding(8)
    }
    
    private var historyList: some View {
        List {
            Section {
                ForEach(viewModel.exchangeRateHistory) { rate in
                    CurrencyHistoryRowView(
                        rate: rate,
                        code: currency.code,
                        shouldHighlight: viewModel.shouldHighlightRate(rate)
                    )
                }
            } header: {
                Text("Historia kursów (ostatnie 2 tygodnie)")
                    .font(.headline)
                    .foregroundColor(.primary)
                    .accessibilityAddTraits(.isHeader)
                    .accessibilityLabel("Sekcja: Historia kursów z ostatnich dwóch tygodni")
            }
        }
        .listStyle(PlainListStyle())
        .accessibilityElement(children: .contain)
        .accessibilityLabel("Lista historii kursów")
        .overlay(
            Group {
                if viewModel.exchangeRateHistory.isEmpty {
                    VStack(spacing: 16) {
                        Image(systemName: "chart.line.downtrend.xyaxis")
                            .font(.system(size: 48))
                            .foregroundColor(.secondary)
                            .accessibilityHidden(true)
                        
                        Text("Brak danych historycznych")
                            .font(.headline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .accessibilityLabel("Brak dostępnych danych historycznych dla tej waluty")
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .accessibilityElement(children: .combine)
                }
            }
        )
    }
}
