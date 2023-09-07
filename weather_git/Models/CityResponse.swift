// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let cityResponse = try? JSONDecoder().decode(CityResponse.self, from: jsonData)

import Foundation

// MARK: - CityResponseElement

struct CityResponseElement: Codable {
    let name: String?
    let lat, lon: Double?
    let country, state: String?

    enum CodingKeys: String, CodingKey {
        case name
        case lat, lon, country, state
    }
}

typealias CityResponse = [CityResponseElement]
