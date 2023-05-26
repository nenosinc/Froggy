//
//  URL+addQueryItems.swift
//  Froggy
//
//  Created by Sam Spencer on 5/26/23.
//  Copyright © 2023 nenos, llc. All rights reserved.
//

import Foundation

public extension URL {
    
    func addQueryItems(_ queryItems: [URLQueryItem]) -> URL {
        var components = URLComponents()
        components.scheme = self.scheme
        components.host = self.host
        components.path = self.path
        components.queryItems = queryItems
        
        guard let newUrl = components.url else {
            return self
        }
        
        return newUrl
    }
    
}
