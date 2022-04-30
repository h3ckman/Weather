//
//  WeatherView.swift
//  Weather
//
//  Created by Alexander Heck on 4/28/22.
//

import SwiftUI
import CoreLocation

struct WeatherView: View {
    @StateObject private var weatherManager = WeatherManager()
    @State var currentLocationWeather: Weather?
    @State var favoritesWeather: [Weather]
    @State var favoriteLocations = (UserDefaults.standard.stringArray(forKey: "Favorites") ?? [String]())
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            List {
                if searchText == "" {
                    if let currentLocationWeather = currentLocationWeather {
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
                    // Show location suggestions based on search text
                }
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: Text("Search City or Zip Code")) {
//                Text("City, State")
//                Text("Zip Code")
            }
                .listStyle(.insetGrouped)
                .navigationTitle("Weather")
        }
            .onAppear() {
            WeatherManager().fetchLocalWeather { weather in self.currentLocationWeather = Weather(data: weather) }
            for favorite in favoriteLocations {
                WeatherManager().fetchWeather(cityZip: favorite, completion: { weather in self.favoritesWeather.append(Weather(data: weather)) })
            }
        }

    }
}

struct CurrentLocationHeader: View {
    var body: some View {
        HStack {
            Image(systemName: "location.fill")
            Text("Current Location")
        }
    }
}

struct FavoritesHeader: View {
    var body: some View {
        HStack {
            Image(systemName: "star.fill")
            Text("Favorite Locations")
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(currentLocationWeather: Weather.sampleData[0], favoritesWeather: Weather.sampleData)
    }
}

