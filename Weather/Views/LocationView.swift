//
//  LocationView.swift
//  Weather
//
//  Created by Alexander Heck on 4/28/22.
//

import SwiftUI

struct LocationView: View {
    @StateObject private var weatherAPIClient = WeatherAPIClient()

    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            if let currentWeather = weatherAPIClient.currentWeather {
                VStack(spacing: 10) {
                    Text(currentWeather.name).font(.largeTitle)
                    HStack(alignment: .center, spacing: 16) {
//                        currentWeather.weather.first!.icon.image.font(.system(size: 56.0))
                        AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(currentWeather.weather.first!.icon)@2x.png")) { image in
                            image.resizable()
                        } placeholder: {
                            Color.clear
                        }
                        .frame(width: 100, height: 100)
                        Text("\(Int(currentWeather.main.temp))ºF").font(.system(size: 56.0))
                    }
                    Text(currentWeather.weather.first!.weatherDescription).font(.body).textCase(.uppercase)
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
