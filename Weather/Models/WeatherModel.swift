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

struct Weather: Identifiable {
    let id = UUID()
    let data: WeatherModel
}

// MARK: - OpenWeatherMap Model
struct WeatherModel: Codable, Identifiable {
    let coord: Coord
    let weather: [WeatherDescription]
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

struct Clouds: Codable {
    let all: Int
}

struct Coord: Codable {
    let lon, lat: Double
}

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

struct Rain: Codable {
    let the1H: Double

    enum CodingKeys: String, CodingKey {
        case the1H = "1h"
    }
}

struct Sys: Codable {
    let type, id: Int
    let country: String
    let sunrise, sunset: Int
}

struct WeatherDescription: Codable {
    let id: Int
    let main, weatherDescription: String
    let icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

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
extension Weather {
    static let sampleData: [Weather] =
    [
        Weather(data: WeatherModel(coord: Coord(lon: 84.111, lat: -53.111), weather: [WeatherDescription(id: 200, main: "Sunny", weatherDescription: "It's very sunny", icon: "01d")], base: "stations", main: Main(temp: 84.543, feelsLike: 86.56, tempMin: 75.123, tempMax: 89.432, pressure: 1018, humidity: 67), visibility: 10000, wind: Wind(speed: 2.57, deg: 60), rain: Rain(the1H: 0.1), clouds: Clouds(all: 100), dt: 1651191306, sys: Sys(type: 2, id: 2008655, country: "US", sunrise: 1651142465, sunset: 1651192010), timezone: -14400, id: 4511939, name: "Dayton", cod: 200)),
        Weather(data: WeatherModel(coord: Coord(lon: 85.111, lat: -53.111), weather: [WeatherDescription(id: 200, main: "Sunny", weatherDescription: "It's very sunny", icon: "01d")], base: "stations", main: Main(temp: 84.543, feelsLike: 86.56, tempMin: 75.123, tempMax: 89.432, pressure: 1018, humidity: 67), visibility: 10000, wind: Wind(speed: 2.57, deg: 60), rain: Rain(the1H: 0.1), clouds: Clouds(all: 100), dt: 1651191306, sys: Sys(type: 2, id: 2008655, country: "US", sunrise: 1651142465, sunset: 1651192010), timezone: -14400, id: 4511939, name: "Cincinnati", cod: 200))
    ]
}
