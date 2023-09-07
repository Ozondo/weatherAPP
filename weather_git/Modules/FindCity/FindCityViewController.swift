//
//  FindCityViewController.swift
//  weather_git
//
//  Created by Егор Иванов on 14.06.2023.
//

import UIKit

final class FindCityViewController: UIViewController {
    let moduleView = FindCityView()
    var names: [String] = []

    var coordinatesSend: ((Double, Double) -> Void)?

    var currentResponse: CityResponse?

    override func loadView() {
        view = moduleView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .black

        moduleView.updateTextChanged = {[weak self] text in
            Task{
                do{
                    self?.currentResponse = try await ApiService.shared.getCoordinations(cityName: text)

                    guard let response = self?.currentResponse else {return}

                    self?.names = response.compactMap({ response in
                        return "\(response.name ?? "") \(response.country ?? "")"
                    })
                    self?.moduleView.updateFindCityView(props: .init(names: self?.names ?? []))
                } catch{
                    print(error)
                }
            }
        }
        moduleView.updateCellTapped = {[weak self] index in
            guard let lat = self?.currentResponse?[index].lat else {return}
            guard let lon = self?.currentResponse?[index].lon else {return}

            self?.coordinatesSend?(lat, lon)

            StorageService.shared.saveCoordinates(coord: (lat, lon))

            self?.navigationController?.popViewController(animated: true)
        }
    }
}
