//
//  CurrencyListViewModel.swift
//  RecruitmentApp
//
//  Created by Jacek Stąporek on 08/09/2025.
//

import Foundation
import SwiftUI
import Observation

@Observable
@MainActor
final class CurrencyListViewModel {
    var viewState: ViewState = .loading
    var currencies: [Currency] = []
    
    private let fetchAllCurrenciesUseCase: FetchAllCurrenciesUseCaseProtocol
    
    init(fetchAllCurrenciesUseCase: FetchAllCurrenciesUseCaseProtocol) {
        self.fetchAllCurrenciesUseCase = fetchAllCurrenciesUseCase
    }
    
    func loadCurrencies() {
        Task {
            await fetchCurrencies()
        }
    }
    
    func refreshData() {
        Task {
            await fetchCurrencies()
        }
    }
    
    private func fetchCurrencies() async {
        viewState = .loading
        
        do {
            currencies = try await fetchAllCurrenciesUseCase.execute()
            viewState = .loaded
        } catch {
            viewState = .error(error)
        }
    }
}
