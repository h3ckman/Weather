//
//  DetailedWeatherView.swift
//  Weather
//
//  Created by Alexander Heck on 4/29/22.
//

import SwiftUI

struct DetailedWeatherView: View {
    var weather: Weather
    @StateObject var weatherManager = WeatherManager()
    @State var favoriteLocations = (UserDefaults.standard.stringArray(forKey: "Favorites") ?? [])
    @State private var showingPopover = false
    var body: some View {
        VStack(alignment: .center) {
            weatherDetailsView()
            Spacer()
            hourlyWeatherView()
        }.toolbar { toolbarView() }
    }

    func weatherDetailsView() -> some View {
        VStack(spacing: 5) {
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
        }.padding(.bottom, 10)
    }

    func hourlyWeatherView() -> some View {
        List {
            Section(header: hourlyWeatherHeader()) {
                ForEach(HourlyWeather.sampleData) { weather in
                    HStack(alignment: .center) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(weather.time)
                            Text(weather.description)
                        }
                        Spacer()
                        VStack(alignment: .trailing) {
                            Label("\(Int(weather.temp))ºF", systemImage: weather.icon)
                                .font(.title2)
                        }
                    }.padding(5)
                }
            }
        }
        .listStyle(.inset)
    }
    
    func hourlyWeatherHeader() -> some View {
        HStack {
            Image(systemName: "cloud")
            Text("Hourly Forecast")
        }
//        .listRowInsets(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
    }

    func toolbarView() -> some View {
        Group {
            if (!favoriteLocations.contains(weather.data.name)) {
                Button(action: {
                    favoriteLocations.append(weather.data.name)
                    UserDefaults.standard.set(favoriteLocations, forKey: "Favorites")
                }, label: {
                        Label("Add Favorite", systemImage: "star")
                    })
            }
            else {
                Button(action: {
                    favoriteLocations = favoriteLocations.filter { $0 != weather.data.name }
                    UserDefaults.standard.set(favoriteLocations, forKey: "Favorites")
                }, label: {
                        Label("Remove Favorite", systemImage: "star.fill")
                    })
            }
        }
    }

//    func getWeatherData() {
//        WeatherManager().fetchWeather(cityZip: weather.data.name, completion: { weather in self.hourlyWeather = weather })
//    }
}

struct DetailedWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedWeatherView(weather: Weather.sampleData[0])
    }
}
