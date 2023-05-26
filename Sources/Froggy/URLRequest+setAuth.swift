//
//  URLRequest+setAuth.swift
//  Froggy
//
//  Created by Sam Spencer on 5/26/23.
//  Copyright © 2023 nenos, llc. All rights reserved.
//

import Foundation

public extension URLRequest {
    
    mutating func setAuthorization(_ header: AuthorizationHeader?) {
        guard let authHeader = header else { return }
        
        guard let allHeaders = allHTTPHeaderFields else {
            addValue(authHeader.value, forHTTPHeaderField: authHeader.name)
            return
        }
        
        let hasAuthHeader = allHeaders.contains { (key, _) in
            key == authHeader.name
        }
        
        if hasAuthHeader {
            setValue(authHeader.value, forHTTPHeaderField: authHeader.name)
        } else {
            addValue(authHeader.value, forHTTPHeaderField: authHeader.name)
        }
    }
    
}
