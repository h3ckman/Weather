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
    private let dateFormatter = ISO8601DateFormatter()
    private let units = "imperial"

    override init() {
        super.init()
        locationManager.delegate = self
        requestLocation()
    }

    func fetchWeather() async {
        guard let location = locationManager.location else {
            requestLocation()
            return
        }

//        guard let url = URL(string: "https://api.tomorrow.io/v4/timelines?location=\(location.coordinate.latitude),\(location.coordinate.longitude)&fields=temperature&fields=weatherCode&units=metric&timesteps=1h&startTime=\(dateFormatter.string(from: Date()))&endTime=\(dateFormatter.string(from: Date().addingTimeInterval(60 * 60)))&apikey={$YOUR_KEY}") else {
//            return
//        }

        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?units=\(units)&lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&appid=cf002751564a4c78f5f7ed479f1b9ba3") else {
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let response = try? JSONDecoder().decode(WeatherModel.self, from: data) {
//                currentWeather = weatherResponse.data.timelines.first?.intervals.first?.values
                currentWeather = response;
                DispatchQueue.main.async { [weak self] in
                    self?.currentWeather = response
                }
            }
        } catch {
            // handle the error
        }
    }

    private func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        Task { await fetchWeather() }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // handle the error
    }
}
