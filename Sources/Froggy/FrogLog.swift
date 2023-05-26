//
//  FrogLog.swift
//  Froggy
//
//  Created by Sam Spencer on 5/26/23.
//  Copyright © 2023 nenos, llc. All rights reserved.
//

import Foundation

internal func frogLog(_ items: Any...) {
    if Froggy.shared.verboseLogging {
        print("[Froggy] ", items)
    }
}
