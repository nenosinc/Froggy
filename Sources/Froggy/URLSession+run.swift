//
//  URLSession+run.swift
//  Froggy
//
//  Created by Sam Spencer on 5/26/23.
//  Copyright © 2023 nenos, llc. All rights reserved.
//

import Foundation

public extension URLSession {
    
    func run<T: Decodable>(
        _ request: URLRequest,
        _ decoder: JSONDecoder = JSONDecoder()
    ) async throws -> DataSourceResponse<T> {
        do {
            frogLog("Running URLSession with request: \(request)")
            
            let (data, response) = try await data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                frogLog("Received nil response from request.")
                throw DataError.genericNetworkingFailure(code: 1000)
            }
            
            frogLog("Request returned a \(httpResponse.statusCode) status code")
            
            switch httpResponse.statusCode {
            case 200...299:
                do {
                    let value = try decoder.decode(T.self, from: data)
                    return DataSourceResponse(value: value, response: response)
                } catch let error {
                    print("[Froggy] WARNING: API CONTRACT BROKEN FOR REQUEST: \(request.url?.absoluteString ?? "")")
                    print("[Froggy] ERROR: \(error)")
                    throw error
                }
            case 401, 403, 405, 422:
                throw DataError.notAuthed
            case 404:
                throw DataError.nothingLoaded
            default:
                throw DataError.genericNetworkingFailure(code: httpResponse.statusCode)
            }
        } catch let error {
            frogLog("Failed to successfully run or complete request: \(request). Error: \(error)")
            throw error
        }
    }
    
    func runWithoutResults(_ request: URLRequest) async throws {
        do {
            frogLog("Running URLSession with request: \(request)")
            
            let (_, response) = try await data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                frogLog("Received nil response from request.")
                throw DataError.genericNetworkingFailure(code: 1000)
            }
            
            frogLog("Request returned a \(httpResponse.statusCode) status code")
            
            switch httpResponse.statusCode {
            case 200...299:
                frogLog("Request successful.")
                return
            case 401, 403, 405, 422: throw DataError.notAuthed
            case 404: throw DataError.nothingLoaded
            default: throw DataError.genericNetworkingFailure(code: httpResponse.statusCode)
            }
        } catch let error {
            frogLog("Failed to successfully run or complete request: \(request). Error: \(error)")
            throw error
        }
    }
}
