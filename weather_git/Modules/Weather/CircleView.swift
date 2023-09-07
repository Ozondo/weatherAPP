//
//  CircleView.swift
//  weather_git
//
//  Created by Егор Иванов on 29.05.2023.
//

import UIKit

final class CircleView: UIView {
    struct Props{
        var temp: Double
    }

    private lazy var imageOfWeather = UIImageView()
    private lazy var imageRaining = UIImage(named: "weather")
    private lazy var temperature = UILabel()

    init() {
        super.init(frame: .zero)
        viewSetup()
        elementsConfig()
        constrainsConfig()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CircleView{
    func uptadeInfoToCirle(props: Props){
        temperature.text = "\(props.temp)°C"
    }
}

private extension CircleView{
    func viewSetup(){
        backgroundColor = .white
        addSubview(imageOfWeather)
        addSubview(temperature)
    }
    func elementsConfig(){
        imageOfWeather.image = imageRaining
        imageOfWeather.contentMode = .scaleAspectFit

        temperature.font = UIFont(name: "Optima Regular", size: 60)
        temperature.numberOfLines = 0
    }
    func constrainsConfig(){
        imageOfWeather.translatesAutoresizingMaskIntoConstraints = false
        temperature.translatesAutoresizingMaskIntoConstraints = false

        imageOfWeather.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageOfWeather.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true

        temperature.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        temperature.topAnchor.constraint(equalTo: topAnchor, constant: 100).isActive = true
    }
}
