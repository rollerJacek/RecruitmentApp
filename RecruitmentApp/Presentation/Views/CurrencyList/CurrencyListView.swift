//
//  CurrencyListView.swift
//  RecruitmentApp
//
//  Created by Jacek Stąporek on 08/09/2025.
//

import SwiftUI

struct CurrencyListView: View {
    @State private var viewModel: CurrencyListViewModel
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    
    init(viewModel: CurrencyListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            VStack {
                switch viewModel.viewState {
                case .loading:
                    LoadingView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                case .loaded:
                    currencyList
                case .error(let error):
                    ErrorView(message: error.localizedDescription) {
                        viewModel.loadCurrencies()
                    }
                }
            }
            .navigationTitle("Kursy Walut NBP")
            .navigationBarTitleDisplayMode(dynamicTypeSize.isAccessibilitySize ? .large : .automatic)
            .accessibilityLabel("Lista kursów walut NBP")
            .accessibilityHint("Przewiń w górę lub w dół aby zobaczyć więcej walut")
            .onAppear {
                if viewModel.currencies.isEmpty {
                    viewModel.loadCurrencies()
                }
            }
            .refreshable {
                viewModel.refreshData()
            }
        }
        .accessibilityElement(children: .contain)
    }
    
    private var currencyList: some View {
        List(viewModel.currencies) { currency in
            NavigationLink(
                destination: CurrencyDetailView(currency: currency)
            ) {
                CurrencyRowView(currency: currency)
            }
            .accessibilityHint("Dwukrotnie dotknij aby zobaczyć szczegóły kursu waluty \(currency.name)")
            .accessibilityAddTraits(.isButton)
        }
        .listStyle(PlainListStyle())
        .accessibilityElement(children: .contain)
        .accessibilityLabel("Lista walut")
    }
}
