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

struct Weather: Identifiable, Equatable {
    static func == (lhs: Weather, rhs: Weather) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id = UUID()
    let data: WeatherModel
}

struct HourlyWeather: Identifiable {
    var id = UUID()
    let time: String
    let temp: Double
    let description: String
    let icon: String
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
    
    var image: String {
        switch icon {
        case "01d", "01n":
            return "sun.max.fill"
        case "02d", "02n":
            return "cloud.sun.fill"
        case "03d", "03n", "04d", "04n":
            return "cloud.fill"
        case "09d", "09n", "10d", "10n":
            return "cloud.rain.fill"
        case "11d", "11n":
            return "cloud.bolt.fill"
        case "50d", "50n":
            return "cloud.fog.fill"
        case "13d", "13n":
            return "snow"
        default:
            return "sun.max.fill"
        }
    }
}

struct Wind: Codable {
    let speed: Double
    let deg: Int
}

extension Weather {
    static let sampleData: [Weather] =
    [
        Weather(data: WeatherModel(coord: Coord(lon: 84.111, lat: -53.111), weather: [WeatherDescription(id: 200, main: "Sunny", weatherDescription: "It's very sunny", icon: "01d")], base: "stations", main: Main(temp: 84.543, feelsLike: 86.56, tempMin: 75.123, tempMax: 89.432, pressure: 1018, humidity: 67), visibility: 10000, wind: Wind(speed: 2.57, deg: 60), rain: Rain(the1H: 0.1), clouds: Clouds(all: 100), dt: 1651191306, sys: Sys(type: 2, id: 2008655, country: "US", sunrise: 1651142465, sunset: 1651192010), timezone: -14400, id: 4511939, name: "Dayton", cod: 200)),
        Weather(data: WeatherModel(coord: Coord(lon: 85.111, lat: -53.111), weather: [WeatherDescription(id: 200, main: "Sunny", weatherDescription: "It's very sunny", icon: "02d")], base: "stations", main: Main(temp: 84.543, feelsLike: 86.56, tempMin: 75.123, tempMax: 89.432, pressure: 1018, humidity: 67), visibility: 10000, wind: Wind(speed: 2.57, deg: 60), rain: Rain(the1H: 0.1), clouds: Clouds(all: 100), dt: 1651191306, sys: Sys(type: 2, id: 2008655, country: "US", sunrise: 1651142465, sunset: 1651192010), timezone: -14400, id: 4511939, name: "Cincinnati", cod: 200))
    ]
}

extension HourlyWeather {
    static let sampleData: [HourlyWeather] =
    [
        HourlyWeather(time: "9:00AM", temp: 68.542, description: "Sunny", icon: "sun.max.fill"),
        HourlyWeather(time: "10:00AM", temp: 70.542, description: "Sunny", icon: "sun.max.fill"),
        HourlyWeather(time: "11:00AM", temp: 72.542, description: "Partly Cloudy", icon: "cloud.sun.fill"),
        HourlyWeather(time: "12:00PM", temp: 73.542, description: "Partly Cloudy", icon: "cloud.sun.fill"),
        HourlyWeather(time: "1:00PM", temp: 73.542, description: "Cloudy", icon: "cloud.fill"),
        HourlyWeather(time: "2:00PM", temp: 74.542, description: "Sunny", icon: "sun.max.fill"),
        HourlyWeather(time: "3:00PM", temp: 75.542, description: "Sunny", icon: "sun.max.fill"),
        HourlyWeather(time: "4:00PM", temp: 75.542, description: "Sunny", icon: "sun.max.fill"),
        HourlyWeather(time: "5:00PM", temp: 75.542, description: "Cloudy", icon: "cloud.fill"),
        HourlyWeather(time: "6:00PM", temp: 74.542, description: "Cloudy", icon: "cloud.fill")
    ]
}
