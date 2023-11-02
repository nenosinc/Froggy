//
//  DataSourceResponse.swift
//  Froggy
//
//  Created by Sam Spencer on 12/14/22.
//  Copyright © 2023 nenos, llc. All rights reserved.
//

import Foundation

public struct DataSourceResponse<T> {
    public let value: T
    public let response: URLResponse
}
