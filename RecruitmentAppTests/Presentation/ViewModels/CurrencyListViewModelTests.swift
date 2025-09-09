//
//  CurrencyListViewModelTests.swift
//  RecruitmentApp
//
//  Created by Jacek Stąporek on 09/09/2025.
//

import Testing
@testable import RecruitmentApp

@Suite("Currency List ViewModel Tests") @MainActor
struct CurrencyListViewModelTests {
    var sut: CurrencyListViewModel!
    var mockUseCase: MockFetchAllCurrenciesUseCase!
    
    init() async {
        mockUseCase = MockFetchAllCurrenciesUseCase()
        sut = CurrencyListViewModel(fetchAllCurrenciesUseCase: mockUseCase)
    }
    
    @Test("Load currencies successfully updates state")
    func loadCurrenciesSuccess() async {
        let mockCurrencies = [
            Currency.mock(
                code: "USD",
                name: "dolar amerykański",
                currentRate: 3.6214,
                tableNo: "173/A/NBP/2025"
            ),
            Currency.mock(
                code: "EUR",
                name: "euro",
                currentRate: 4.2484,
                tableNo: "173/A/NBP/2025"
            )
        ]
        mockUseCase.currenciesToReturn = mockCurrencies

        sut.loadCurrencies()
        try? await Task.sleep(for: .milliseconds(400))
        
        #expect(sut.currencies.count == 2)
        #expect(sut.viewState == .loaded)
        #expect(mockUseCase.executeCalled == true)
        
        let usd = sut.currencies.first { $0.code == "USD" }
        #expect(usd?.currentRate == 3.6214)
        #expect(usd?.tableNo == "173/A/NBP/2025")
    }
    
    @Test("Load currencies handles failure correctly")
    func loadCurrenciesFailure() async {
        mockUseCase.shouldThrowError = true
        mockUseCase.errorToThrow = NetworkError.notFound

        sut.loadCurrencies()
        try? await Task.sleep(for: .milliseconds(400))
        
        #expect(sut.currencies.isEmpty)
        #expect(sut.viewState == .error(NetworkError.notFound))
    }
    
    @Test("Refresh data calls use case again")
    func refreshData() async {
        mockUseCase.currenciesToReturn = [Currency.mock()]
        sut.loadCurrencies()
        mockUseCase.executeCalled = false

        sut.refreshData()
        try? await Task.sleep(for: .milliseconds(400))
        
        #expect(mockUseCase.executeCalled == true)
    }
}
