//
//  ContentView.swift
//  Weather
//
//  Created by Alexander Heck on 4/28/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationView {
                LocationView()
            }.tabItem {
                Image(systemName: "location.fill")
                Text("My Location")
            }
            NavigationView {
                FavoritesView()
            }
                .tabItem {
                Image(systemName: "star.fill")
                Text("Favorites")
            }


            NavigationView {
                SearchView()
            }.tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search")
            }
        }

    }
}

struct FavoritesView: View {
    var body: some View {
        Text("Favorites")
            .navigationBarTitle("Favorites")

    }
}

struct LocationView: View {
    @StateObject private var weatherAPIClient = WeatherAPIClient()

    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            if let currentWeather: WeatherModel = weatherAPIClient.currentWeather {
                VStack(spacing: 10) {
                    Text(currentWeather.name).font(.largeTitle)
                    HStack(alignment: .center, spacing: 16) {
                        Image(systemName: "sun.max.fill").font(.largeTitle)
                        Text("\(Int(currentWeather.main.temp))ºF").font(.system(size: 56.0))
                    }
                    HStack(alignment: .center, spacing: 20) {
                        Text("H: \(Int(currentWeather.main.tempMax))ºF").font(.system(size: 26.0))
                        Text("L: \(Int(currentWeather.main.tempMin))ºF").font(.system(size: 26.0))
                    }
                }

            } else {
                Text("No weather info available yet.\nTap on refresh to fetch new data.\nMake sure you have enabled location permissions for the app.")
                    .font(.body)
                    .multilineTextAlignment(.center)
                Button("Refresh", action: {
                    Task {
                        await weatherAPIClient.fetchWeather()
                    }
                })
            }
            Spacer()
        }
            .padding(.top, 50)
            .navigationBarTitle("My Location")

    }
}

struct SearchView: View {
    var body: some View {
        Text("Search")
            .navigationBarTitle("Search")

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
