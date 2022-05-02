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
    @State var currentLocationWeather: Weather?
    @State var favoritesWeather: [Weather]

    @State private var searchText = ""
    @State private var weatherSearch: Weather? = nil

    @State private var isShowingDetailView = false

    var body: some View {
        if(NetworkReachability().reachable) {
            if let currentLocationWeather = weatherManager.currentWeather ?? currentLocationWeather {
                NavigationView {
                    VStack {

                        // Hidden NavigationLink triggers when search is initiated
                        if let weatherSearch = weatherSearch {
                            NavigationLink(destination: DetailedWeatherView(weather: weatherSearch), isActive: $isShowingDetailView) { EmptyView() }
                        }

                        // List with sections for current location and favorites
                        List {
                            currentLocationView(weather: currentLocationWeather)
                            favoritesView()
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
            else {
                if(favoritesWeather.isEmpty) {
                    emptyWeatherView()
                }
            }
        }
        else {
            noNetworkView()
        }
    }

    // MARK: Views
    
    func currentLocationView(weather: Weather) -> some View {
        Group {
            Section(header: currentLocationHeader()) {
                NavigationLink(destination: DetailedWeatherView(weather: weather)) {
                    CardView(weather: weather)
                }
            }

        }
    }

    func favoritesView() -> some View {
        Group {
            if !favoritesWeather.isEmpty {
                Section(header: favoriteLocationsHeader()) {
                    ForEach(favoritesWeather.sorted(by: { $0.data.name < $1.data.name })) { weather in
                        NavigationLink(destination: DetailedWeatherView(weather: weather)) {
                            CardView(weather: weather)
                        }
                    }
                }
            }
        }
    }

    func emptyWeatherView() -> some View {
        VStack(alignment: .center, spacing: 10) {
            Image(systemName: "exclamationmark.triangle").font(.largeTitle)
            Text("No weather info available yet").font(.title2)
            Text("Have you enabled location services?")
                .font(.body)
                .multilineTextAlignment(.center)
            Button("Refresh", action: {
                getWeatherData()
            }).buttonStyle(.borderedProminent)
        }
    }

    func noNetworkView() -> some View {
        VStack(alignment: .center, spacing: 10) {
            Image(systemName: "bolt.horizontal").font(.largeTitle)
            Text("No network connection!").font(.title2)
            Text("This app requires a network connection. Please ensure WiFi or data is enabled and you are connected.")
                .font(.body)
                .multilineTextAlignment(.center)
            Button("Settings", action: {
                // Go to settings
            }).buttonStyle(.borderedProminent)
        }
    }

    func currentLocationHeader() -> some View {
        HStack {
            Image(systemName: "location.fill")
            Text("Current Location")
        }
            .listRowInsets(EdgeInsets(top: 15, leading: 10, bottom: 10, trailing: 10))
    }


    func favoriteLocationsHeader() -> some View {
        HStack {
            Image(systemName: "star.fill")
            Text("Favorite Locations")
        }
            .listRowInsets(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
    }


    // MARK: Helper Functions
    
    /// Gets current local and favorited location weather from WeatherManager
    func getWeatherData() {
        Task { await weatherManager.fetchLocalWeather() }
        if let favoriteLocations = (UserDefaults.standard.stringArray(forKey: "Favorites")) {
            favoritesWeather = []
            for favorite in favoriteLocations {
                WeatherManager().fetchWeather(cityZip: favorite, completion: { weather in self.favoritesWeather.append(Weather(data: weather)) })
            }
        }
    }

    func searchWeather(weather: WeatherModel) {
        searchText = ""
        weatherSearch = Weather(data: weather)
        isShowingDetailView = true
    }

}

// MARK: Preview

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WeatherView(currentLocationWeather: Weather.sampleData[0], favoritesWeather: Weather.sampleData)
            WeatherView(favoritesWeather: [])
        }
    }
}

