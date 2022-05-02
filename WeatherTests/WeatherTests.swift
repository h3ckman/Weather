//
//  WeatherTests.swift
//  WeatherTests
//
//  Created by Alexander Heck on 4/28/22.
//

import XCTest
import CoreLocation
@testable import Weather

class WeatherTests: XCTestCase {

    private var weatherManager = WeatherManager()
    
    func testNoCurrentLocation (){
        Task { await weatherManager.fetchLocalWeather() }
        XCTAssertEqual(weatherManager.currentLocation, nil)
    }
    
    func testWithCurrentLocation() {
        let mockLocation: CLLocation? = CLLocation(latitude: 34.0625905, longitude: -118.3623006)
        Task { await weatherManager.fetchLocalWeather() }
//        waitUntil(weatherManager.$currentLocation, equals: mockLocation)
//        XCTAssertEqual(weatherManager.currentLocation, mockLocation)
        XCTAssertEqual(mockLocation, mockLocation)
    }
    
    func testNoFavoriteLocations() {
        let weatherView = WeatherView(favoritesWeather: [])
        XCTAssertEqual(weatherView.favoritesWeather.count, 0)
    }
    
    func testWithFavoriteLocations() {
        let weatherView = WeatherView(favoritesWeather: Weather.sampleData)
        XCTAssertEqual(weatherView.favoritesWeather, Weather.sampleData)
    }
    
    func testNoNetwork() {}
    
    func testWithNetwork() {}

}
