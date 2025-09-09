//
//  FetchAllCurrenciesUseCaseTests.swift
//  RecruitmentApp
//
//  Created by Jacek Stąporek on 09/09/2025.
//

import Testing
@testable import RecruitmentApp

@Suite("Fetch All Currencies Use Case Tests")
struct FetchAllCurrenciesUseCaseTests {
    var sut: FetchAllCurrenciesUseCase!
    var mockRepository: MockCurrencyRepository!
    
    init() {
        mockRepository = MockCurrencyRepository()
        sut = FetchAllCurrenciesUseCase(repository: mockRepository)
    }
    
    @Test("Execute returns currencies successfully")
    func executeSuccess() async throws {
        let expectedCurrencies = [
            Currency.mock(code: "USD", name: "dolar amerykański"),
            Currency.mock(code: "EUR", name: "euro")
        ]
        mockRepository.currenciesToReturn = expectedCurrencies

        let result = try await sut.execute()

        #expect(result.count == 2)
        #expect(result.first?.code == "USD")
        #expect(mockRepository.fetchAllAvailableCurrenciesCalled == true)
    }
    
    @Test("Execute throws error when repository fails")
    func executeFailure() async throws {
        mockRepository.shouldThrowError = true
        mockRepository.errorToThrow = NetworkError.serverError(500)

        await #expect(throws: NetworkError.self) {
            try await sut.execute()
        }
        #expect(mockRepository.fetchAllAvailableCurrenciesCalled == true)
    }
    
    @Test("Execute propagates specific network errors")
    func executeNetworkErrorPropagation() async throws {
        mockRepository.shouldThrowError = true
        mockRepository.errorToThrow = NetworkError.notFound

        await #expect(throws: NetworkError.notFound) {
            try await sut.execute()
        }
    }
}
