//
//  WeatherView.swift
//  Weather
//
//  Created by Alexander Heck on 4/28/22.
//

import SwiftUI
import CoreLocation

struct WeatherView: View {
    @StateObject var weatherManager = WeatherManager()
    @State var favoritesWeather: [Weather]
    @State var favoriteLocations = (UserDefaults.standard.stringArray(forKey: "Favorites") ?? [String]())

    @State private var searchText = ""
    @State private var weatherSearch: Weather? = nil

    @State private var isShowingDetailView = false

    var body: some View {
        NavigationView {
            VStack {

                // Hidden NavigationLink triggers when search is initiated
                if let weatherSearch = weatherSearch {
                    NavigationLink(destination: DetailedWeatherView(weather: weatherSearch), isActive: $isShowingDetailView) {
                        EmptyView()
                    }
                }

                // List with sections for current location and favorites
                List {
                    if searchText == "" {
                        if let currentLocationWeather = weatherManager.currentWeather {
                            Section(header: CurrentLocationHeader()) {
                                NavigationLink(destination: DetailedWeatherView(weather: currentLocationWeather)) {
                                    CardView(weather: currentLocationWeather)
                                }
                            }
                        }
                        if !favoritesWeather.isEmpty {
                            Section(header: FavoritesHeader()) {
                                ForEach(favoritesWeather) { weather in
                                    NavigationLink(destination: DetailedWeatherView(weather: weather)) {
                                        CardView(weather: weather)
                                    }
                                }
                            }
                        }
                    }
                    else {
                        // TODO: Show location suggestions based on search text
                    }
                }
                    .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always)
                    , prompt: Text("Search City or Zip Code")
                    , suggestions: {
                        Text("City: Cincinnati").searchCompletion("cincinnati")
                        Text("Zip Code: 45036").searchCompletion("45036")
                    })
                    .onSubmit(of: .search) {
                    WeatherManager().fetchWeather(cityZip: searchText, completion: searchWeather)
                }
                    .listStyle(.insetGrouped)
                    .navigationTitle("Weather")
            }
                .onAppear() { getWeatherData() }
                .refreshable {
                    getWeatherData()
                }
        }
    }

    /// Gets current local and favorited location weather from WeatherManager
    func getWeatherData() {
        Task { await weatherManager.fetchLocalWeather() }
        favoritesWeather = []
        favoriteLocations = (UserDefaults.standard.stringArray(forKey: "Favorites") ?? [String]())
        favoriteLocations = favoriteLocations.sorted(by: {$0 < $1})
        for favorite in favoriteLocations {
            WeatherManager().fetchWeather(cityZip: favorite, completion: { weather in self.favoritesWeather.append(Weather(data: weather)) })
        }
    }

    func searchWeather(weather: WeatherModel) {
        searchText = ""
        weatherSearch = Weather(data: weather)
        isShowingDetailView = true
    }
}

struct CurrentLocationHeader: View {
    var body: some View {
        HStack {
            Image(systemName: "location.fill")
            Text("Current Location")
        }
            .listRowInsets(EdgeInsets(top: 15, leading: 10, bottom: 10, trailing: 10))
    }
}

struct FavoritesHeader: View {
    var body: some View {
        HStack {
            Image(systemName: "star.fill")
            Text("Favorite Locations")
        }
            .listRowInsets(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
    }
}

// TODO: fix preview
struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(favoritesWeather: Weather.sampleData)
    }
}

