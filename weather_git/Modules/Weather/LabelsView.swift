import UIKit

final class LabelsView: UIView {
    struct Props{
        var infoLabel: String
        var valueLabel: String
    }

    private lazy var firstLabel = UILabel()
    private lazy var secondLabel = UILabel()
    private lazy var allStack = UIStackView()

    init() {
        super.init(frame: .zero)
        viewConfig()
        elementsConfig()
        constrainsConfig()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LabelsView{
    func updateLabelsView(props: Props){
        firstLabel.text = props.infoLabel
        secondLabel.text = "\(props.valueLabel)"
    }
}

private extension LabelsView{
    func viewConfig(){
        addSubview(allStack)
    }
    func elementsConfig(){
        firstLabel.font = UIFont(name: "Optima Regular", size: 14)

        secondLabel.font = UIFont(name: "Optima Regular", size: 20)

        allStack.axis = .vertical
        allStack.spacing = 8
        allStack.addArrangedSubview(firstLabel)
        allStack.addArrangedSubview(secondLabel)
    }
    func constrainsConfig(){
        allStack.translatesAutoresizingMaskIntoConstraints = false

        allStack.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        allStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -40).isActive = true
    }
}
