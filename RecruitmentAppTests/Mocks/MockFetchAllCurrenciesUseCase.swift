//
//  MockFetchAllCurrenciesUseCase.swift
//  RecruitmentApp
//
//  Created by Jacek Stąporek on 09/09/2025.
//

import Foundation
@testable import RecruitmentApp

final class MockFetchAllCurrenciesUseCase: FetchAllCurrenciesUseCaseProtocol {
    var currenciesToReturn: [Currency] = []
    var shouldThrowError = false
    var errorToThrow: Error = NetworkError.serverError(500)
    var executeCalled = false
    
    func execute() async throws -> [Currency] {
        executeCalled = true
        
        if shouldThrowError {
            throw errorToThrow
        }
        
        return currenciesToReturn
    }
}
