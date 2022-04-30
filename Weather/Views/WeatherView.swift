//
//  WeatherView.swift
//  Weather
//
//  Created by Alexander Heck on 4/28/22.
//

import SwiftUI
import CoreLocation

struct WeatherView: View {
//    @State var currentLocationWeather: Weather?
    @StateObject var weatherManager = WeatherManager()
    @State var favoritesWeather: [Weather]
    
    @State var favoriteLocations = (UserDefaults.standard.stringArray(forKey: "Favorites") ?? [String]())
    @State private var searchText = ""
    @State private var isShowingDetailView = false
    
    @State private var weatherSearch: Weather? = nil
    
//    init(currentLocationWeather: Weather?, favoritesWeather: [Weather]) {
//        _favoritesWeather = State(initialValue: favoritesWeather)
//        _currentLocationWeather = State(initialValue: weatherManager.currentWeather)
//    }
    
    var body: some View {
        NavigationView {
            VStack{
                if let weatherSearch = weatherSearch {
                    NavigationLink(destination: DetailedWeatherView(weather: weatherSearch), isActive: $isShowingDetailView) {
                        EmptyView()
                    }
                }
            
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
                    // Show location suggestions based on search text
                }
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: Text("Search City or Zip Code"), suggestions: {
                Text("City: Cincinnati").searchCompletion("cincinnati")
                Text("Zip Code: 45036").searchCompletion("45036")
            })
            .onSubmit(of: .search) {
                WeatherManager().fetchWeather(cityZip: searchText, completion: searchWeather)
            }
                .listStyle(.insetGrouped)
                .navigationTitle("Weather")
        }
            .onAppear() {
                Task { await weatherManager.fetchLocalWeather() }
                favoritesWeather = []
                favoriteLocations = (UserDefaults.standard.stringArray(forKey: "Favorites") ?? [String]())
            for favorite in favoriteLocations {
                WeatherManager().fetchWeather(cityZip: favorite, completion: { weather in self.favoritesWeather.append(Weather(data: weather)) })
            }
        }
        }
    }
    
    func searchWeather(weather: WeatherModel) {
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
        WeatherView(favoritesWeather: Weather.sampleData)
    }
}

