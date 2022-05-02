//
//  WeatherApp.swift
//  Weather
//
//  Created by Alexander Heck on 4/28/22.
//

import SwiftUI

@main
struct WeatherApp: App {
    var body: some Scene {
        WindowGroup {
            if ProcessInfo.processInfo.arguments.contains("UI_TESTS") {
                WeatherView(currentLocationWeather: Weather.sampleData[0], favoritesWeather: Weather.sampleData)
            }
            else {
                WeatherView(favoritesWeather: [])
            }
        }
    }
}
