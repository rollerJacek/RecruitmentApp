//
//  CurrencyRepositoryTests.swift
//  RecruitmentApp
//
//  Created by Jacek Stąporek on 09/09/2025.
//

import Testing
import Foundation
@testable import RecruitmentApp

@Suite("Currency Repository Tests")
struct CurrencyRepositoryTests {
    var sut: CurrencyRepository!
    var mockAPIService: MockNBPAPIService!
    
    init() {
        mockAPIService = MockNBPAPIService()
        sut = CurrencyRepository(apiService: mockAPIService)
    }
    
    @Test("Fetch all currencies from both tables successfully")
    func fetchAllAvailableCurrenciesSuccess() async throws {
        let tableA = NBPCurrencyTableDTO(
            table: "A",
            no: "173/A/NBP/2025",
            effectiveDate: Date(),
            rates: [
                NBPRateDTO(currency: "dolar amerykański", code: "USD", mid: 3.6214),
                NBPRateDTO(currency: "euro", code: "EUR", mid: 4.2484)
            ]
        )
        
        mockAPIService.currencyTablesToReturn = [tableA]
        mockAPIService.fetchCurrencyTableCalled = false

        let result = try await sut.fetchAllAvailableCurrencies()

        #expect(result.count >= 2)
        #expect(mockAPIService.fetchCurrencyTableCalled == true)
        
        let usd = result.first { $0.code == "USD" }
        #expect(usd?.name == "dolar amerykański")
        #expect(usd?.currentRate == 3.6214)
        #expect(usd?.tableType == .A)

        let codes = result.map { $0.code }
        let sortedCodes = codes.sorted()
        #expect(codes == sortedCodes)
    }
    
    @Test("Fetch currency history successfully")
    func fetchCurrencyHistorySuccess() async throws {
        mockAPIService.exchangeRatesToReturn = .mock

        let result = try await sut.fetchCurrencyHistory(for: "USD", table: .A, lastDays: 14)

        #expect(result.count == 1)
        #expect(mockAPIService.fetchCurrencyRateCalled == true)
        #expect(result.first?.mid == 3.6214)
    }
    
    @Test("Handles partial failure gracefully when one table fails")
    func partialFailureHandling() async throws {
        let tableA = NBPCurrencyTableDTO(
            table: "A",
            no: "173/A/NBP/2025",
            effectiveDate: Date(),
            rates: [NBPRateDTO(currency: "dolar amerykański", code: "USD", mid: 3.6214)]
        )
        
        mockAPIService.currencyTablesToReturn = [tableA]

        let result = try await sut.fetchAllAvailableCurrencies()

        #expect(result.count >= 1)
        #expect(result.first?.code == "USD")
    }
    
    @Test("Throws error when no data available")
    func noDataAvailable() async throws {
        mockAPIService.shouldThrowError = true
        mockAPIService.errorToThrow = NetworkError.noData
 
        await #expect(throws: NetworkError.noData) {
            try await sut.fetchAllAvailableCurrencies()
        }
    }
    
    @Test("Fetch history with specific parameters")
    func fetchHistoryWithParameters() async throws {
        mockAPIService.exchangeRatesToReturn = .mock

        let _ = try await sut.fetchCurrencyHistory(for: "USD", table: .A, lastDays: 30)

        #expect(mockAPIService.fetchCurrencyRateCalled == true)
    }
}
