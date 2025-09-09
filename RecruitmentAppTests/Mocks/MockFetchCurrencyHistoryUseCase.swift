//
//  MockFetchCurrencyHistoryUseCase.swift
//  RecruitmentApp
//
//  Created by Jacek Stąporek on 09/09/2025.
//

import Foundation
@testable import RecruitmentApp

final class MockFetchCurrencyHistoryUseCase: FetchCurrencyHistoryUseCaseProtocol {
    var historyToReturn: [ExchangeRate] = []
    var shouldThrowError = false
    var errorToThrow: Error = NetworkError.serverError(500)
    var executeCalled = false
    var lastCurrency: Currency?
    var lastDays: Int?
    
    func execute(for currency: Currency, lastDays: Int) async throws -> [ExchangeRate] {
        executeCalled = true
        lastCurrency = currency
        self.lastDays = lastDays
        
        if shouldThrowError {
            throw errorToThrow
        }
        
        return historyToReturn
    }
}
