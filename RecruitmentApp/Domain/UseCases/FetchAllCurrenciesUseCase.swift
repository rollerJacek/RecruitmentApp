//
//  FetchAllCurrenciesUseCase.swift
//  RecruitmentApp
//
//  Created by Jacek Stąporek on 08/09/2025.
//

import Foundation

protocol FetchAllCurrenciesUseCaseProtocol {
    func execute() async throws -> [Currency]
}

final class FetchAllCurrenciesUseCase: FetchAllCurrenciesUseCaseProtocol {
    private let repository: CurrencyRepositoryProtocol
    
    init(repository: CurrencyRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() async throws -> [Currency] {
        return try await repository.fetchAllAvailableCurrencies()
    }
}
