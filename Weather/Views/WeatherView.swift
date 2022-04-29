//
//  WeatherView.swift
//  Weather
//
//  Created by Alexander Heck on 4/28/22.
//

import SwiftUI

struct WeatherView: View {
    @State var currentLocationWeather: WeatherModel?
    @State var favoritesWeather: [WeatherModel]
    @State private var searchText = ""
    let names = ["Holly", "Josh", "Rhonda", "Ted"]

    var body: some View {
        NavigationView {
            List {
                if let currentLocationWeather = currentLocationWeather {
                    Section(header: CurrentLocationHeader()) {
                        CardView(weather: currentLocationWeather)
                    }
                }
                if !favoritesWeather.isEmpty {
                    Section(header: FavoritesHeader()) {
                        ForEach(favoritesWeather, id: ) { weather in
                            CardView(weather: weather)
                        }
                    }
                }

            }.listStyle(GroupedListStyle())
                .onAppear() {
                WeatherAPIClient().fetchWeather { weather in
                    self.currentLocationWeather = weather
                }
            }
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
                .navigationTitle("Weather")
        }
    }

    var searchResults: [String] {
        if searchText.isEmpty {
            return names
        } else {
            return names.filter { $0.contains(searchText) }
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
        WeatherView(currentLocationWeather: WeatherModel.sampleData[0], favoritesWeather: WeatherModel.sampleData)
    }
}

