//
//  ViewController.swift
//  weather_git_version
//
//  Created by Егор Иванов on 28.05.2023.
//

import UIKit

class WeatherViewController: UIViewController {
    let moduleView = WeatherView()

    override func loadView() {
        view = moduleView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        createRightBar()

        guard let coord = StorageService.shared.fetchCoordinates() else {return}

        Task{
            do{
                let weather = try await ApiService.shared.getWeather(lat: coord.0, lon: coord.1)

                guard
                    let country = weather.sys?.country,
                    let city = weather.name,
                    let temp = weather.main?.temp,
                    let windvalue = weather.wind?.speed,
                    let humidityValue = weather.main?.humidity,
                    let visabilityValue = weather.visibility,
                    let airpressureValue = weather.main?.pressure
                else{
                    return
                }

                moduleView.uptateWeatherView(
                    props:
                        .init(
                            country: country,
                            city: city,
                            temp: temp,
                            windlabel: "Wind stasus",
                            windvalue: windvalue,
                            humidityLabel: "Humidity",
                            humidityValue: humidityValue,
                            visabilityLabel: "Visability",
                            visabilityValue: visabilityValue,
                            airpressureLabel: "Air Pressure",
                            airpressureValue: airpressureValue
                        )
                )
            } catch{
                print(error)
            }
        }
    }
}

extension WeatherViewController{
    private func createRightBar(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "magnifyingglass"),
            style: .done,
            target: self,
            action: #selector(rightBarTapped)
        )
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    @objc
    func rightBarTapped() {
        let findVC = FindCityViewController()
        navigationController?.pushViewController(findVC, animated: true)

        findVC.coordinatesSend = {[weak self] lat, lon in
            Task{
                do{
                    let weather = try await ApiService.shared.getWeather(lat: lat, lon: lon)

                    self?.moduleView.uptateWeatherView(
                        props:
                            .init(
                                country: weather.sys?.country ?? "",
                                city: weather.name ?? "",
                                temp: weather.main?.temp ?? 0,
                                windlabel: "Wind stasus",
                                windvalue: weather.wind?.speed ?? 0,
                                humidityLabel: "Humidity",
                                humidityValue: weather.main?.humidity ?? 0,
                                visabilityLabel: "Visability",
                                visabilityValue: weather.visibility ?? 0,
                                airpressureLabel: "Air Pressure",
                                airpressureValue: weather.main?.pressure ?? 0
                            )
                    )
                } catch{
                    print(error)
                }
            }
        }
    }
}
