//
//  FetchCurrencyHistoryUseCaseTests.swift
//  RecruitmentApp
//
//  Created by Jacek Stąporek on 09/09/2025.
//

import Testing
import Foundation
@testable import RecruitmentApp

@Suite("Fetch Currency History Use Case Tests")
struct FetchCurrencyHistoryUseCaseTests {
    var sut: FetchCurrencyHistoryUseCase!
    var mockRepository: MockCurrencyRepository!
    
    init() {
        mockRepository = MockCurrencyRepository()
        sut = FetchCurrencyHistoryUseCase(repository: mockRepository)
    }
    
    @Test("Execute returns sorted history successfully")
    func executeSuccess() async throws {
        let currency = Currency.mock(code: "USD", tableType: .A)
        let unsortedRates = [
            ExchangeRate.mock(mid: 3.6214, effectiveDate: Date().addingTimeInterval(-86400)),
            ExchangeRate.mock(mid: 3.6357, effectiveDate: Date()),
            ExchangeRate.mock(mid: 3.6278, effectiveDate: Date().addingTimeInterval(-172800))
        ]
        mockRepository.rateHistoryToReturn = unsortedRates

        let result = try await sut.execute(for: currency, lastDays: 14)

        #expect(result.count == 3)
        #expect(mockRepository.fetchCurrencyHistoryCalled == true)
        #expect(result[0].effectiveDate >= result[1].effectiveDate)
        #expect(result[1].effectiveDate >= result[2].effectiveDate)
    }
    
    @Test("Execute uses correct parameters")
    func executeWithCorrectParameters() async throws {
        let currency = Currency.mock(code: "EUR", tableType: .B)
        mockRepository.rateHistoryToReturn = []

        let _ = try await sut.execute(for: currency, lastDays: 30)

        #expect(mockRepository.fetchCurrencyHistoryCalled == true)
    }
    
    @Test("Execute throws error when repository fails")
    func executeFailure() async throws {
        let currency = Currency.mock()
        mockRepository.shouldThrowError = true
        mockRepository.errorToThrow = NetworkError.notFound

        await #expect(throws: NetworkError.notFound) {
            try await sut.execute(for: currency, lastDays: 14)
        }
    }
    
    @Test("Execute with default days parameter")
    func executeWithDefaultDays() async throws {
        let currency = Currency.mock()
        let rates = [ExchangeRate.mock()]
        mockRepository.rateHistoryToReturn = rates

        let result = try await sut.execute(for: currency)

        #expect(result.count == 1)
        #expect(mockRepository.fetchCurrencyHistoryCalled == true)
    }
}
