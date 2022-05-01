//
//  WeatherAPIClient.swift
//  Weather
//
//  Created by Alexander Heck on 4/28/22.
//

import Foundation
import CoreLocation

final class WeatherManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var currentWeather: Weather?
    @Published var currentLocation: CLLocation?

    private let locationManager = CLLocationManager()
    private let units = "imperial"

    override init() {
        super.init()
        locationManager.delegate = self
        requestLocation()
    }

    func fetchLocalWeather() async {
        guard let location = locationManager.location else {
            requestLocation()
            return
        }

        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?units=\(units)&lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&appid=cf002751564a4c78f5f7ed479f1b9ba3") else { return }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let weatherResponse = try? JSONDecoder().decode(WeatherModel.self, from: data) {
                DispatchQueue.main.async { [weak self] in
                    self?.currentWeather = Weather(data: weatherResponse)
                }
            }
        }
        catch { }
    }

    func fetchWeather(cityZip: String, completion: @escaping (WeatherModel) -> ()) {
        
        // Change query param based on type of input
        let query = (Int(cityZip) != nil) ? "zip=\(Int(cityZip)!)" : "q=\(cityZip.replacingOccurrences(of: " ", with: "+"))"

        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?units=\(units)&\(query)&appid=cf002751564a4c78f5f7ed479f1b9ba3") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let weather = try? JSONDecoder().decode(WeatherModel.self, from: data!) {
                DispatchQueue.main.async {
                    completion(weather)
                }
            }
        }.resume()
    }

    func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        Task { await fetchLocalWeather() }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // handle the error
    }
}
