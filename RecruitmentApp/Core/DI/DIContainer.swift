//
//  DIContainer.swift
//  RecruitmentApp
//
//  Created by Jacek Stąporek on 08/09/2025.
//

import Foundation

protocol DIContainerProtocol {
    func resolve<T>(_ type: T.Type) -> T
}

final class DIContainer: @unchecked Sendable, DIContainerProtocol {
    static let shared = DIContainer()
    
    private var services: [String: Any] = [:]
    private let lock: NSLock = NSLock()
    
    private init() {
        registerServices()
    }
    
    func resolve<T>(_ type: T.Type) -> T {
        lock.lock()
        defer { lock.unlock() }
        let key = String(describing: type)
        guard let service = services[key] as? T else {
            fatalError("Service \(key) not registered. Available services: \(Array(services.keys))")
        }
        return service
    }
    
    private func registerService<T>(_ type: T.Type, _ service: T) {
        services[String(describing: type)] = service
    }
}

extension DIContainer {
    private func registerServices() {
        let apiService = NBPAPIService()
        registerService(NBPAPIServiceProtocol.self, apiService)
        
        let currencyRepository = CurrencyRepository(apiService: apiService)
        registerService(CurrencyRepositoryProtocol.self, currencyRepository)

        let fetchAllCurrenciesUseCase = FetchAllCurrenciesUseCase(repository: currencyRepository)
        registerService(FetchAllCurrenciesUseCaseProtocol.self, fetchAllCurrenciesUseCase)
        
        let fetchCurrencyHistoryUseCase = FetchCurrencyHistoryUseCase(repository: currencyRepository)
        registerService(FetchCurrencyHistoryUseCaseProtocol.self, fetchCurrencyHistoryUseCase)
    }
}

#if DEBUG
extension DIContainer {
    public func getServices() -> [String: Any]  {
        return services
    }
    
    public func registerServiceTest<T>(_ type: T.Type, _ service: T) {
        registerService(type, service)
    }
}
#endif
