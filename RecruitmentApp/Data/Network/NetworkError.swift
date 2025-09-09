//
//  NetworkError.swift
//  RecruitmentApp
//
//  Created by Jacek Stąporek on 08/09/2025.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case notFound
    case badRequest
    case serverError(Int)
    case decodingError
    case noData
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Nieprawidłowy URL"
        case .invalidResponse:
            return "Nieprawidłowa odpowiedź serwera"
        case .notFound:
            return "Brak danych dla wybranego zakresu"
        case .badRequest:
            return "Nieprawidłowe zapytanie"
        case .serverError(let code):
            return "Błąd serwera: \(code)"
        case .decodingError:
            return "Błąd parsowania danych"
        case .noData:
            return "Brak danych"
        }
    }
}
