// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let weatherResponse = try? JSONDecoder().decode(WeatherResponse.self, from: jsonData)

import Foundation

// MARK: - WeatherResponse

struct WeatherResponse: Codable {
    let coord: Coord?
    let weather: [Weather]?
    let base: String?
    let main: Main?
    let visibility: Int?
    let wind: Wind?
    let clouds: Clouds?
    let data: Int?
    let sys: Syss?
    let timezone, id: Int?
    let name: String?
    let cod: Int?
}

// MARK: - Clouds

struct Clouds: Codable {
    let all: Int?
}

// MARK: - Coord

struct Coord: Codable {
    let lon, lat: Double?
}

// MARK: - Main

struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double?
    let pressure, humidity, seaLevel, grndLevel: Int?

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
    }
}

// MARK: - Sys

struct Syss: Codable {
    let type, id: Int?
    let country: String?
    let sunrise, sunset: Int?
}

// MARK: - Weather

struct Weather: Codable {
    let id: Int?
    let main, description, icon: String?
}

// MARK: - Wind

struct Wind: Codable {
    let speed: Double?
    let deg: Int?
    let gust: Double?
}
