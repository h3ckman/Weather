//
//  WeatherUITests.swift
//  WeatherUITests
//
//  Created by Alexander Heck on 4/28/22.
//

import XCTest

class WeatherUITests: XCTestCase {
    let app = XCUIApplication()
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launchArguments = ["UI_TESTS"]
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEmptyWeather() throws {
        app.launchArguments = []
        app.launch()

        let weatherError = app.staticTexts["No weather info available yet"]
        XCTAssert(weatherError.exists)
    }

    func testRefreshButton() throws {
        app.launchArguments = []
        app.launch()
        
        let refreshButton = app.buttons["Refresh"]
        XCTAssert(refreshButton.exists)
        XCTAssertEqual(refreshButton.label, "Refresh")
    }
    
    func testWeatherList() throws {
        app.launch()
        
        let weatherNavTitle = app.staticTexts["Weather"]
        XCTAssert(weatherNavTitle.waitForExistence(timeout: 0.5))
        
        let currentLocationHeader = app.staticTexts["Current Location"]
        XCTAssert(currentLocationHeader.exists)
        
        let favoriteLocationHeaders = app.staticTexts["Favorite Locations"]
        XCTAssert(favoriteLocationHeaders.exists)
        
        let currentLocation = app.staticTexts["Dayton"]
        XCTAssert(currentLocation.exists)

        let favoriteLocation = app.staticTexts["Cincinnati"]
        XCTAssert(favoriteLocation.exists)
    }
    
    /// Open the app, load the initial view, click detail view
    func testWeatherDetailFlow() {
        app.launch()
        
        app.staticTexts["Cincinnati"].tap()
        
        let favoriteLocation = app.staticTexts["Cincinnati"]
        XCTAssert(favoriteLocation.exists)
        
        let navButton = app.buttons["Add Favorite"]
        XCTAssert(navButton.exists)
    }
    
    /// Open the app, load the initial view, search, add favorite
    func testAddFavorite() {
        app.launch()
        
        app.staticTexts["Cincinnati"].tap()
        
        let navButton = app.buttons["Add Favorite"]
        navButton.tap()
        
        XCTAssertEqual(navButton.label, "Add Favorite")
    }
    
    /// Open the app, load the initial view, search, add favorite
    func testSearch() {
        app.launch()

        app.navigationBars["Weather"].searchFields["Search City or Zip Code"].tap()
        app.tables.cells["Zip Code: 45036"].tap()
        
        let navButton = app.buttons["Add Favorite"]
        
        XCTAssert(navButton.waitForExistence(timeout: 0.5))
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
