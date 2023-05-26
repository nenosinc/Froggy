//
//  AuthorizationHeader.swift
//  Froggy
//
//  Created by Sam Spencer on 5/26/23.
//  Copyright © 2023 nenos, llc. All rights reserved.
//

import Foundation

public struct AuthorizationHeader {
    
    public let name: String
    public let value: String
    
    public init(name: String, value: String) {
        self.name = name
        self.value = value
        
    }
}
