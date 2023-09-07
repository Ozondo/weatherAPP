//
//  StorageService.swift
//  weather_git
//
//  Created by Егор Иванов on 25.06.2023.
//

import Foundation

struct StorageService {
    static let shared = StorageService()

    private let userDefaults = UserDefaults.standard

    enum Keys: String {
        case lat
        case lon
    }

    func saveCoordinates(coord: (Double, Double)) {
        userDefaults.set(coord.0, forKey: Keys.lat.rawValue)
        userDefaults.set(coord.1, forKey: Keys.lon.rawValue)
    }
    func fetchCoordinates () -> (Double, Double)? {
        let lat = userDefaults.double(forKey: Keys.lat.rawValue)
        let lon = userDefaults.double(forKey: Keys.lon.rawValue)

        return (lat, lon)
    }
}
