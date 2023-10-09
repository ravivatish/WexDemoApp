//
//  ConnectionError.swift
//  DemoApp
//
//  Created by Ravi Vitash on 10/9/23.
//

import Foundation

enum ConnectionError: Error {
    case networkError
    case decodingFailed
    case unknown
}
