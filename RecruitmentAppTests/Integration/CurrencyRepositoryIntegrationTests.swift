//
//  CurrencyRepositoryIntegrationTests.swift
//  RecruitmentApp
//
//  Created by Jacek Stąporek on 09/09/2025.
//

import Testing
import Foundation
@testable import RecruitmentApp

@Suite("Currency Repository Integration Tests")
struct CurrencyRepositoryIntegrationTests {
    
    @Test("Repository integrates correctly with API service")
    func repositoryIntegration() async throws {
        let mockAPIService = MockNBPAPIService()
        let repository = CurrencyRepository(apiService: mockAPIService)
        
        let tableDTO = NBPCurrencyTableDTO(
            table: "A",
            no: "173/A/NBP/2025",
            effectiveDate: Date(),
            rates: [
                NBPRateDTO(currency: "dolar amerykański", code: "USD", mid: 3.6214)
            ]
        )
        mockAPIService.currencyTablesToReturn = [tableDTO]

        let currencies = try await repository.fetchAllAvailableCurrencies()

        #expect(currencies.count == 2)
        #expect(currencies.first?.code == "USD")
        #expect(currencies.first?.currentRate == 3.6214)
        #expect(mockAPIService.fetchCurrencyTableCalled == true)
    }
    
    @Test("Use case integrates correctly with repository")
    func useCaseIntegration() async throws {
        let mockRepository = MockCurrencyRepository()
        let useCase = FetchAllCurrenciesUseCase(repository: mockRepository)
        
        let currencies = [
            Currency.mock(code: "USD"),
            Currency.mock(code: "EUR")
        ]
        mockRepository.currenciesToReturn = currencies

        let result = try await useCase.execute()

        #expect(result.count == 2)
        #expect(mockRepository.fetchAllAvailableCurrenciesCalled == true)
    }
}
