//
//  URLRequest+setMethod.swift
//  Froggy
//
//  Created by Sam Spencer on 5/26/23.
//  Copyright © 2023 nenos, llc. All rights reserved.
//

import Foundation

public extension URLRequest {
    
    func setMethod(_ method: HttpMethod) -> URLRequest {
        var newRequest = self
        newRequest.httpMethod = method.rawValue
        return newRequest
    }
    
}
