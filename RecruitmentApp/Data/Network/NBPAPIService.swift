//
//  NBPAPIService.swift
//  RecruitmentApp
//
//  Created by Jacek Stąporek on 08/09/2025.
//

import Foundation

protocol NBPAPIServiceProtocol {
    func fetchCurrencyTable(type: TableType) async throws -> [NBPCurrencyTableDTO]
    func fetchCurrencyRate(table: TableType, code: String, last count: Int) async throws -> NBPCurrencyRateResponseDTO
}

final class NBPAPIService: NBPAPIServiceProtocol {
    private let session: URLSession
    private let jsonDecoder: JSONDecoder
    
    init(session: URLSession = .shared) {
        self.session = session
        self.jsonDecoder = JSONDecoder()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
    }
    
    func fetchCurrencyTable(type: TableType) async throws -> [NBPCurrencyTableDTO] {
        let endpoint: NBPEndpoint = type == .A ? .currencyTablesA : .currencyTablesB
        return try await performRequest(url: endpoint.url)
    }
    
    func fetchCurrencyRate(table: TableType, code: String, last count: Int) async throws -> NBPCurrencyRateResponseDTO {
        let endpoint = NBPEndpoint.currencyRateHistory(table: table, code: code, days: count)
        return try await performRequest(url: endpoint.url)
    }
    
    private func performRequest<T: Codable>(url: String) async throws -> T {
        guard let url = URL(string: url) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.timeoutInterval = Constants.API.timeout
        
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }
            
            switch httpResponse.statusCode {
            case 200:
                do {
                    return try jsonDecoder.decode(T.self, from: data)
                } catch {
                    print("Decoding error: \(error.localizedDescription)")
                    if let jsonString = String(data: data, encoding: .utf8) {
                        print("JSON response: \(jsonString)")
                    }
                    throw NetworkError.decodingError
                }
            case 404:
                throw NetworkError.notFound
            case 400:
                throw NetworkError.badRequest
            default:
                throw NetworkError.serverError(httpResponse.statusCode)
            }
        } catch {
            if error is NetworkError {
                throw error
            }
            throw NetworkError.serverError(0)
        }
    }
}
