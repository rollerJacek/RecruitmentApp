//
//  DIContainerTests.swift
//  RecruitmentApp
//
//  Created by Jacek Stąporek on 09/09/2025.
//

import Testing
import Foundation
@testable import RecruitmentApp

@Suite("DIContainer Tests")
struct DIContainerTests {
    @Test("Check resolving")
    func checkResolve() {
        let apiService = DIContainer.shared.resolve(NBPAPIServiceProtocol.self)
        #expect(apiService != nil)
    }
    
    @Test("Check Count")
    func checkCount() {
        let services = DIContainer.shared.getServices()
        #expect(services.count == 4)
    }
    
    @MainActor @Test("Check registering")
    func checkRegistering() {
        let mock = MockFetchAllCurrenciesUseCase()
        let testService = CurrencyListViewModel(fetchAllCurrenciesUseCase: mock)
        DIContainer.shared.registerServiceTest(CurrencyListViewModel.self, testService)
        let services = DIContainer.shared.getServices()
        #expect(services.count == 5)
    }
}
