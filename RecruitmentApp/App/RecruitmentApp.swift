//
//  RecruitmentApp.swift
//  RecruitmentApp
//
//  Created by Jacek Stąporek on 08/09/2025.
//

import SwiftUI

@main
struct RecruitmentApp: App {
    var body: some Scene {
        WindowGroup {
            CurrencyListView(
                viewModel: CurrencyListViewModel(
                    fetchAllCurrenciesUseCase: DIContainer.shared.resolve(FetchAllCurrenciesUseCaseProtocol.self)
                )
            )
        }
    }
}
