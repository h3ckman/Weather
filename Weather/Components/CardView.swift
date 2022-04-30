//
//  CardView.swift
//  Weather
//
//  Created by Alexander Heck on 4/29/22.
//

import Foundation
import SwiftUI

struct CardView: View {
    let weather: Weather
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(weather.data.name).font(.title2)
                Spacer()
                Text("\(weather.data.weather.first!.weatherDescription)").font(.caption).textCase(.uppercase)
            }

            Spacer()
            VStack(alignment: .trailing) {
                Label("\(Int(weather.data.main.temp))ºF", systemImage: "sun.max.fill").font(.title2)
                Spacer()
                HStack(alignment: .center, spacing: 20) {
                    Text("H: \(Int(weather.data.main.tempMax))ºF").font(.caption)
                    Text("L: \(Int(weather.data.main.tempMin))ºF").font(.caption)
                }
            }

        }.padding(10)
    }
}

struct CardView_Previews: PreviewProvider {
    static var weather = Weather.sampleData[0]
    static var previews: some View {
        CardView(weather: weather)
            .background(Color.blue)
            .previewLayout(.fixed(width: 400, height: 80))
    }
}
