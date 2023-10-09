//
//  GeocoderModel.swift
//  DemoApp
//
//  Created by ravinder kumar on 10/9/23.
//

import Foundation

struct GeocoderModel: Codable {
    let lat: Float
    let lon: Float
    let name : String
    let state: String
    let country: String
}
