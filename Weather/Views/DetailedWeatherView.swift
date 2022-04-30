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
    var body: some View {
        VStack(alignment: .center) {
            VStack(spacing: 10) {
                Text(weather.data.name).font(.largeTitle)
                HStack(alignment: .center, spacing: 16) {
                    //                        currentWeather.weather.first!.icon.image.font(.system(size: 56.0))
                    AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(weather.data.weather.first!.icon)@2x.png")) { image in
                        image.resizable()
                    } placeholder: {
                        Color.clear
                    }
                        .frame(width: 100, height: 100)
                    Text("\(Int(weather.data.main.temp))ºF").font(.system(size: 56.0))
                }
                Text(weather.data.weather.first!.weatherDescription).font(.body).textCase(.uppercase)
                HStack(alignment: .center, spacing: 20) {
                    Text("H: \(Int(weather.data.main.tempMax))ºF").font(.system(size: 26.0))
                    Text("L: \(Int(weather.data.main.tempMin))ºF").font(.system(size: 26.0))
                }
            }

            Spacer()
        }
            .toolbar(content: {
            Button {
                print(favoriteLocations)
                favoriteLocations.append(weather.data.name)
                UserDefaults.standard.set(favoriteLocations, forKey: "Favorites")
            } label: {
                Label("Favorite", systemImage: "star")
            }
        })
            .padding(.top, 100)
            .onAppear() {
//                WeatherManager().fetchWeather(cityZip: favorite as! String, completion: { weather in self.favoritesWeather.append(Weather(data: weather)) })
        }
    }
}

struct DetailedWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedWeatherView(weather: Weather.sampleData[0])
    }
}
