//
//  WeatherModel.swift
//  Weather
//
//  Created by Alexander Heck on 4/28/22.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON:
//
//   let weatherModel = try? newJSONDecoder().decode(WeatherModel.self, from: jsonData)

import Foundation
import SwiftUI

// MARK: - WeatherModel
struct WeatherModel: Codable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind?
    let rain: Rain?
    let clouds: Clouds?
    let dt: Int
    let sys: Sys
    let timezone, id: Int
    let name: String
    let cod: Int
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double
}

// MARK: - Main
struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

// MARK: - Rain
struct Rain: Codable {
    let the1H: Double

    enum CodingKeys: String, CodingKey {
        case the1H = "1h"
    }
}

// MARK: - Sys
struct Sys: Codable {
    let type, id: Int
    let country: String
    let sunrise, sunset: Int
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main, weatherDescription: String
    let icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double
    let deg: Int
}

enum WeatherCode: String, Codable {
    case clear = "01d"
    case partlyCloudy = "02d"
    case cloudy = "03d"
    case veryCloudy = "04d"
    case rain = "09d"
    case moreRain = "10d"
    case thunderstorms = "11d"
    case snow = "13d"
    case fog = "50d"

    var image: Image {
        switch self {
        case .clear:
            return Image(systemName: "sun.max.fill")
        case .partlyCloudy:
            return Image(systemName: "cloud.sun.fill")
        case .cloudy, .veryCloudy:
            return Image(systemName: "cloud.fill")
        case .rain, .moreRain:
            return Image(systemName: "cloud.rain.fill")
        case .thunderstorms:
            return Image(systemName: "cloud.bolt.fill")
        case .fog:
            return Image(systemName: "cloud.fog.fill")
        case .snow:
            return Image(systemName: "snow")
        }
    }
}
