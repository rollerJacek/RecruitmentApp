//
//  ExchangeRates.swift
//  RecruitmentApp
//
//  Created by Jacek Stąporek on 08/09/2025.
//

import Foundation

struct ExchangeRate: Identifiable {
    let id = UUID()
    let mid: Double
    let effectiveDate: Date
    let tableNo: String
    
    func isSignificantlyDifferent(from currentRate: Double) -> Bool {
        let difference = abs(mid - currentRate) / currentRate
        return difference > Constants.UI.significantRateChangeThreshold
    }
}
