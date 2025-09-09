//
//  Constants.swift
//  RecruitmentApp
//
//  Created by Jacek Stąporek on 08/09/2025.
//

import Foundation

struct Constants {
    struct API {
        static let baseURL = "https://api.nbp.pl/api"
        static let timeout: TimeInterval = 30.0
    }
    
    struct UI {
        static let searchDebounceTime: Int = 300
        static let significantRateChangeThreshold: Double = 0.1
        static let defaultHistoryDays = 14
    }
}
