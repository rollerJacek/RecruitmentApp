//
//  NBPEndPoint.swift
//  RecruitmentApp
//
//  Created by Jacek Stąporek on 08/09/2025.
//

import Foundation

enum NBPEndpoint {
    case currencyTablesA
    case currencyTablesB
    case currencyRateHistory(table: TableType, code: String, days: Int)
    
    var url: String {
        let baseURL = Constants.API.baseURL
        switch self {
        case .currencyTablesA:
            return "\(baseURL)/exchangerates/tables/a/"
        case .currencyTablesB:
            return "\(baseURL)/exchangerates/tables/b/"
        case .currencyRateHistory(let table, let code, let days):
            return "\(baseURL)/exchangerates/rates/\(table.rawValue.lowercased())/\(code.lowercased())/last/\(days)/"
        }
    }
}
