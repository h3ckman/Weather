//
//  CardView.swift
//  Weather
//
//  Created by Alexander Heck on 4/29/22.
//

import Foundation
import SwiftUI

struct CardView: View {
    let weather: WeatherModel
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(weather.name).font(.title)
                Spacer()
                Text("\(weather.weather.first!.weatherDescription)").font(.caption).textCase(.uppercase)
            }

            Spacer()
            VStack {
                Label("\(Int(weather.main.temp))ºF", systemImage: "sun.max.fill").font(.title)
                Spacer()
                HStack(alignment: .center, spacing: 20) {
                    Text("H: \(Int(weather.main.tempMax))ºF").font(.caption)
                    Text("L: \(Int(weather.main.tempMin))ºF").font(.caption)
                }
            }

        }.padding(10)

    }
}

struct CardView_Previews: PreviewProvider {
    static var weather = WeatherModel.sampleData[0]
    static var previews: some View {
        CardView(weather: weather)
            .background(Color.blue)
            .previewLayout(.fixed(width: 400, height: 80))
    }
}
