//
//  URLRequest+addHeaders.swift
//  Froggy
//
//  Created by Sam Spencer on 5/26/23.
//  Copyright © 2023 nenos, llc. All rights reserved.
//

import Foundation

public extension URLRequest {
    
    func addHeaders(_ headers: [String: String]) -> URLRequest {
        var newRequest = self
        
        guard let allCurrentHeaders = allHTTPHeaderFields else {
            newRequest.allHTTPHeaderFields = headers
            return newRequest
        }
        
        let allHeaders = allCurrentHeaders.merging(headers) { original, _ in
            return original
        }
        
        newRequest.allHTTPHeaderFields = allHeaders
        return newRequest
    }
    
    func setHeaders(_ headers: [String: String]) -> URLRequest {
        var newRequest = self
        newRequest.allHTTPHeaderFields = headers
        return newRequest
    }
    
    func addHeaders(_ headers: [RequestHeader]) -> URLRequest {
        let newHeaders = headers.reduce(into: [:]) { partialResult, header in
            partialResult[header.name] = header.value
        }
        
        return addHeaders(newHeaders)
    }
    
    func setHeaders(_ headers: [RequestHeader]) -> URLRequest {
        var newRequest = self
        newRequest.allHTTPHeaderFields = headers.reduce(into: [:], { partialResult, header in
            partialResult[header.name] = header.value
        })
        return newRequest
    }
    
}
