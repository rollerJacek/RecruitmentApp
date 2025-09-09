//
//  MockCurrencyRepository.swift
//  RecruitmentApp
//
//  Created by Jacek Stąporek on 09/09/2025.
//

import Foundation
@testable import RecruitmentApp

final class MockCurrencyRepository: CurrencyRepositoryProtocol {
    var currenciesToReturn: [Currency] = []
    var rateHistoryToReturn: [ExchangeRate] = []
    var shouldThrowError = false
    var errorToThrow: Error = NetworkError.serverError(500)
    
    var fetchAllAvailableCurrenciesCalled = false
    var fetchCurrencyHistoryCalled = false
    
    func fetchAllAvailableCurrencies() async throws -> [Currency] {
        fetchAllAvailableCurrenciesCalled = true
        
        if shouldThrowError {
            throw errorToThrow
        }
        
        return currenciesToReturn
    }
    
    func fetchCurrencyHistory(for currencyCode: String, table: TableType, lastDays: Int) async throws -> [ExchangeRate] {
        fetchCurrencyHistoryCalled = true
        
        if shouldThrowError {
            throw errorToThrow
        }
        
        return rateHistoryToReturn
    }
}

