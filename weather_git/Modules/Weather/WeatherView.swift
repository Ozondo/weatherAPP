//
import UIKit

final class WeatherView: UIView {
    struct Props{
        var country: String
        var city: String
        var temp: Double

        var windlabel: String
        var windvalue: Double

        var humidityLabel: String
        var humidityValue: Int

        var visabilityLabel: String
        var visabilityValue: Int

        var airpressureLabel: String
        var airpressureValue: Int
    }

// MARK: - VIEWS

    private lazy var gradientView = CAGradientLayer()

    private lazy var currentDate = UILabel()
    private lazy var currentCity = UILabel()
    private lazy var currentCountry = UILabel()

    private lazy var currentCircle = CircleView()

    private lazy var currentWindStatus = LabelsView()
    private lazy var currentHumidity = LabelsView()
    private lazy var currentVisability = LabelsView()
    private lazy var currentAirPressure = LabelsView()

    private lazy var currentInfoLabelsStack1 = UIStackView()
    private lazy var currentInfoLabelsStack2 = UIStackView()
    private lazy var currentInfoLabelsAllStacks = UIStackView()

    private lazy var egorIvanov = UILabel()

// ---------------------------
// MARK: - LIFECYCLE

    override func layoutSubviews() {
        super.layoutSubviews()

        gradientView.frame = bounds
    }

    init() {
        super.init(frame: .zero)
        gradientView.colors = [UIColor.systemBlue.cgColor, UIColor.white.cgColor]
        layer.addSublayer(gradientView)

        viewSetup()
        elementsConfig()
        constrainsConfig()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
// ----------------------------
}

extension WeatherView{
    func uptateWeatherView(props: Props){
        currentCircle.uptadeInfoToCirle(props: .init(temp: props.temp))

        currentCountry.text = props.country
        currentCity.text = props.city

        currentWindStatus.updateLabelsView(props: .init(infoLabel: props.windlabel, valueLabel: "\(props.windvalue) mph"))

        currentHumidity.updateLabelsView(props: .init(infoLabel: props.humidityLabel, valueLabel: "\(props.humidityValue)%"))

        currentVisability.updateLabelsView(props: .init(infoLabel: props.visabilityLabel, valueLabel: "\(props.visabilityValue) miles"))

        currentAirPressure.updateLabelsView(props: .init(infoLabel: props.airpressureLabel, valueLabel: "\(props.airpressureValue) mb"))
    }
}

private extension WeatherView{
    func viewSetup(){
        addSubview(currentDate)
        addSubview(currentCity)
        addSubview(currentCountry)
        addSubview(currentCircle)
        addSubview(currentInfoLabelsAllStacks)
        addSubview(egorIvanov)
    }
    func elementsConfig(){
        currentCity.font = UIFont(name: "Optima Regular", size: 40)

        currentCountry.font = UIFont(name: "Optima Regular", size: 20)

        currentCircle.layer.cornerRadius = 120

        currentInfoLabelsStack1.axis = .vertical
        currentInfoLabelsStack1.spacing = 100
        currentInfoLabelsStack1.addArrangedSubview(currentWindStatus)
        currentInfoLabelsStack1.addArrangedSubview(currentHumidity)

        currentInfoLabelsStack2.axis = .vertical
        currentInfoLabelsStack2.alignment = .center
        currentInfoLabelsStack2.spacing = 100
        currentInfoLabelsStack2.addArrangedSubview(currentVisability)
        currentInfoLabelsStack2.addArrangedSubview(currentAirPressure)

        currentInfoLabelsAllStacks.axis = .horizontal
        currentInfoLabelsAllStacks.alignment = .center
        currentInfoLabelsAllStacks.spacing = 128
        currentInfoLabelsAllStacks.alignment = .center
        currentInfoLabelsAllStacks.addArrangedSubview(currentInfoLabelsStack1)
        currentInfoLabelsAllStacks.addArrangedSubview(currentInfoLabelsStack2)

        egorIvanov.text = "@developed by Egor Ivanov"
        egorIvanov.font = UIFont(name: "Futura", size: 15)
        egorIvanov.textColor = .black
    }

    func constrainsConfig(){
        currentDate.translatesAutoresizingMaskIntoConstraints = false
        currentCity.translatesAutoresizingMaskIntoConstraints = false
        currentCountry.translatesAutoresizingMaskIntoConstraints = false
        currentCircle.translatesAutoresizingMaskIntoConstraints = false
        currentInfoLabelsAllStacks.translatesAutoresizingMaskIntoConstraints = false
        egorIvanov.translatesAutoresizingMaskIntoConstraints = false

        currentDate.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        currentDate.topAnchor.constraint(equalTo: topAnchor, constant: 86).isActive = true

        currentCity.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        currentCity.topAnchor.constraint(equalTo: topAnchor, constant: 103).isActive = true

        currentCountry.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        currentCountry.topAnchor.constraint(equalTo: topAnchor, constant: 146).isActive = true

        currentCircle.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        currentCircle.topAnchor.constraint(equalTo: topAnchor, constant: 186).isActive = true
        currentCircle.widthAnchor.constraint(equalToConstant: 240).isActive = true
        currentCircle.heightAnchor.constraint(equalToConstant: 240).isActive = true

        currentInfoLabelsAllStacks.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        currentInfoLabelsAllStacks.topAnchor.constraint(equalTo: topAnchor, constant: 500).isActive = true

        egorIvanov.topAnchor.constraint(equalTo: currentInfoLabelsAllStacks.bottomAnchor, constant: 150).isActive = true
        egorIvanov.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
    }
}
