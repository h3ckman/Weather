//
//  WeatherAPIClient.swift
//  Weather
//
//  Created by Alexander Heck on 4/28/22.
//

import Foundation
import CoreLocation

final class WeatherAPIClient: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var currentWeather: WeatherModel?

    private let locationManager = CLLocationManager()
    private let units = "imperial"

    override init() {
        super.init()
        locationManager.delegate = self
        requestLocation()
    }

    func fetchWeather(completion: @escaping (WeatherModel) -> ()) {
        guard let location = locationManager.location else {
            requestLocation()
            return
        }

        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?units=\(units)&lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&appid=cf002751564a4c78f5f7ed479f1b9ba3") else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            let weather = try! JSONDecoder().decode(WeatherModel.self, from: data!)
            print(weather)
            DispatchQueue.main.async {
                completion(weather)
            }
        }.resume()

    }

    private func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        Task { fetchWeather { weather in self.currentWeather = weather } }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // handle the error
    }
}
