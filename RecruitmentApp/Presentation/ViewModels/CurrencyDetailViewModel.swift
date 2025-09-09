//
//  CurrencyDetailViewModel.swift
//  RecruitmentApp
//
//  Created by Jacek Stąporek on 08/09/2025.
//

import Foundation
import SwiftUI
import Observation

@Observable
@MainActor
final class CurrencyDetailViewModel {
    var viewState: ViewState = .loading
    var exchangeRateHistory: [ExchangeRate] = []
    
    private let fetchHistoryUseCase: FetchCurrencyHistoryUseCaseProtocol
    let currency: Currency
    
    init(currency: Currency, fetchHistoryUseCase: FetchCurrencyHistoryUseCaseProtocol) {
        self.currency = currency
        self.fetchHistoryUseCase = fetchHistoryUseCase
    }
    
    func loadHistory() {
        Task {
            await fetchHistory()
        }
    }
    
    func shouldHighlightRate(_ rate: ExchangeRate) -> Bool {
        return rate.isSignificantlyDifferent(from: currency.currentRate)
    }
    
    private func fetchHistory() async {
        viewState = .loading
        
        do {
            exchangeRateHistory = try await fetchHistoryUseCase.execute(for: currency, lastDays: Constants.UI.defaultHistoryDays)
            viewState = .loaded
        } catch {
            viewState = .error(error)
        }
    }
}
