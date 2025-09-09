//
//  CurrencyDetailViewModelTests.swift
//  RecruitmentApp
//
//  Created by Jacek Stąporek on 09/09/2025.
//

import Testing
import Foundation
@testable import RecruitmentApp

@Suite("Currency Detail ViewModel Tests") @MainActor
struct CurrencyDetailViewModelTests {
    var currency: Currency!
    var mockUseCase: MockFetchCurrencyHistoryUseCase!
    var sut: CurrencyDetailViewModel!
    
    init() {
        currency = Currency.mock(
            code: "USD",
            name: "dolar amerykański",
            currentRate: 3.6214
        )
        mockUseCase = MockFetchCurrencyHistoryUseCase()
        sut = CurrencyDetailViewModel(currency: currency, fetchHistoryUseCase: mockUseCase)
    }
    
    @Test("Load history successfully updates state")
    func loadHistorySuccess() async {
        let mockHistory = [
            ExchangeRate.mock(mid: 3.6214, effectiveDate: Date()),
            ExchangeRate.mock(mid: 3.6357, effectiveDate: Date().addingTimeInterval(-86400))
        ]
        mockUseCase.historyToReturn = mockHistory

        sut.loadHistory()
        try? await Task.sleep(for: .milliseconds(400))

        #expect(sut.exchangeRateHistory.count == 2)
        #expect(sut.viewState == .loaded)
        #expect(mockUseCase.executeCalled == true)
    }
    
    @Test("Load history handles failure correctly")
    func loadHistoryFailure() async {
        mockUseCase.shouldThrowError = true
        mockUseCase.errorToThrow = NetworkError.serverError(500)

        sut.loadHistory()
        try? await Task.sleep(for: .milliseconds(400))

        #expect(sut.exchangeRateHistory.isEmpty)
        #expect(sut.viewState == .error(NetworkError.serverError(500)))
    }
    
    @Test("Should highlight rate with significant difference")
    func shouldHighlightSignificantDifference() {
        let significantRate = ExchangeRate.mock(mid: 4.0)

        let shouldHighlight = sut.shouldHighlightRate(significantRate)

        #expect(shouldHighlight == true)
    }
    
    @Test("Should not highlight rate with small difference")
    func shouldNotHighlightSmallDifference() {
        let normalRate = ExchangeRate.mock(mid: 3.65)

        let shouldHighlight = sut.shouldHighlightRate(normalRate)

        #expect(shouldHighlight == false)
    }
    
    @Test("Currency property is correctly set")
    func currencyPropertySet() {
        #expect(sut.currency.code == "USD")
        #expect(sut.currency.name == "dolar amerykański")
        #expect(sut.currency.currentRate == 3.6214)
    }
    
    @Test("Loading state changes correctly during fetch")
    func loadingStateChanges() async {
        mockUseCase.historyToReturn = [ExchangeRate.mock()]

        #expect(sut.viewState == .loading)
        
        sut.loadHistory()
        try? await Task.sleep(for: .milliseconds(400))
        #expect(sut.viewState == .loaded)
    }
}
