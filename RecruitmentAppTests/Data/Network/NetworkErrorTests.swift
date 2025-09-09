//
//  NetworkErrorTests.swift
//  RecruitmentApp
//
//  Created by Jacek Stąporek on 09/09/2025.
//

import Testing
@testable import RecruitmentApp

@Suite("Network Error Tests")
struct NetworkErrorTests {
    
    @Test("Network error descriptions are correct")
    func networkErrorDescriptions() {
        #expect(NetworkError.invalidURL.localizedDescription == "Nieprawidłowy URL")
        #expect(NetworkError.invalidResponse.localizedDescription == "Nieprawidłowa odpowiedź serwera")
        #expect(NetworkError.notFound.localizedDescription == "Brak danych dla wybranego zakresu")
        #expect(NetworkError.badRequest.localizedDescription == "Nieprawidłowe zapytanie")
        #expect(NetworkError.decodingError.localizedDescription == "Błąd parsowania danych")
        #expect(NetworkError.noData.localizedDescription == "Brak danych")
    }
    
    @Test("Server error description includes status code")
    func serverErrorDescription() {
        let error = NetworkError.serverError(500)
        #expect(error.localizedDescription == "Błąd serwera: 500")
    }
    
    @Test("Network errors are equatable")
    func networkErrorEquality() {
        #expect(NetworkError.invalidURL == NetworkError.invalidURL)
        #expect(NetworkError.serverError(500) == NetworkError.serverError(500))
        #expect(NetworkError.serverError(500) != NetworkError.serverError(404))
    }
}

extension NetworkError: @retroactive Equatable {
    public static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL),
             (.invalidResponse, .invalidResponse),
             (.notFound, .notFound),
             (.badRequest, .badRequest),
             (.decodingError, .decodingError),
             (.noData, .noData):
            return true
        case (.serverError(let lhsCode), .serverError(let rhsCode)):
            return lhsCode == rhsCode
        default:
            return false
        }
    }
}
