//
//  Weather.swift
//  Weatherly
//
//  Created by Noam Efergan on 01/05/2021.
//

import Foundation

struct Weather: Codable {
    let location: Location
    let temperature: Temperature

    enum CodingKeys: String, CodingKey {
        case location
        case temperature = "current"
    }
}
