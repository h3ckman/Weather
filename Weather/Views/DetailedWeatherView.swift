//
//  DetailedWeatherView.swift
//  Weather
//
//  Created by Alexander Heck on 4/29/22.
//

import SwiftUI

struct DetailedWeatherView: View {
    var weather: Weather
    @State var favoriteLocations = (UserDefaults.standard.stringArray(forKey: "Favorites") ?? [])
    @State private var showingPopover = false
    var body: some View {
        VStack(alignment: .center) {
            VStack(spacing: 10) {
                Text(weather.data.name).font(.largeTitle)
                HStack(alignment: .center, spacing: 16) {
                    AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(weather.data.weather.first!.icon)@2x.png")) { image in
                        image.resizable()
                    } placeholder: {
                        Color.clear
                    }
                        .frame(width: 100, height: 100)
                    Text("\(Int(weather.data.main.temp))ºF").font(.system(size: 56.0))
                }
                Text(weather.data.weather.first!.weatherDescription).font(.body).textCase(.uppercase)
                HStack(alignment: .center, spacing: 30) {
                    Text("H: \(Int(weather.data.main.tempMax))ºF").font(.system(size: 26.0))
                    Text("L: \(Int(weather.data.main.tempMin))ºF").font(.system(size: 26.0))
                }
            }

            Spacer()
        }
            .toolbar(content: {
            if !favoriteLocations.contains(weather.data.name) {
                Button {
                    favoriteLocations.append(weather.data.name)
                    UserDefaults.standard.set(favoriteLocations, forKey: "Favorites")
                    print(favoriteLocations)
                }
                label: {
                    Label("Favorite", systemImage: "star")
                }
            }
        })
            .padding(.top, 100)
    }
}

struct DetailedWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedWeatherView(weather: Weather.sampleData[0])
    }
}
