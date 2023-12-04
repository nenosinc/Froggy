//
//  Froggy.swift
//  Froggy
//
//  Created by Sam Spencer on 5/26/23.
//  Copyright © 2023 nenos, llc. All rights reserved.
//

public class Froggy {
    
    public static let shared = Froggy()
    
    internal var verboseLogging = false

    public init() {
    }
    
    public func verboseLogging(isOn: Bool) {
        verboseLogging = isOn
    }
    
}
