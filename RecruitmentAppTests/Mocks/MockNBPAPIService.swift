//
//  MockNBPAPIService.swift
//  RecruitmentApp
//
//  Created by Jacek Stąporek on 09/09/2025.
//

import Foundation
@testable import RecruitmentApp

final class MockNBPAPIService: NBPAPIServiceProtocol {
    var currencyTablesToReturn: [NBPCurrencyTableDTO] = []
    var exchangeRatesToReturn: NBPCurrencyRateResponseDTO = .mock
    var shouldThrowError = false
    var errorToThrow: Error = NetworkError.serverError(500)
    
    var fetchCurrencyTableCalled = false
    var fetchCurrencyRateCalled = false
    
    func fetchCurrencyTable(type: TableType) async throws -> [NBPCurrencyTableDTO] {
        fetchCurrencyTableCalled = true
        
        if shouldThrowError {
            throw errorToThrow
        }
        
        return currencyTablesToReturn
    }
    
    func fetchCurrencyRate(table: TableType, code: String, last count: Int) async throws -> NBPCurrencyRateResponseDTO {
        fetchCurrencyRateCalled = true
        
        if shouldThrowError {
            throw errorToThrow
        }
        
        return exchangeRatesToReturn
    }
}

