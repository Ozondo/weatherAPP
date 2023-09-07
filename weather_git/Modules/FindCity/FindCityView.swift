//
//  FindAndCellView.swift
//  weather_git
//
//  Created by Егор Иванов on 14.06.2023.
//

import UIKit

final class FindCityView: UIView {
    var updateTextChanged: ((String) -> Void)?

    var updateCellTapped: ((Int) -> Void)?

    struct Props{
        let names: [String]
    }

    let gradientView = CAGradientLayer()
    private lazy var findAndCell = FindAndCell()

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientView.frame = bounds
    }

    init() {
        super.init(frame: .zero)
        gradientView.colors = [UIColor.systemBlue.cgColor, UIColor.white.cgColor]
        layer.addSublayer(gradientView)
        viewSetup()
        elementsSetup()
        setupConstrains()
        findAndCell.textChanged = { [weak self] text in
            self?.updateTextChanged?(text)
        }

        findAndCell.cellTapped = { [weak self] index in
            self?.updateCellTapped?(index)
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension FindCityView{
    func updateFindCityView(props: Props){
        findAndCell.uptadeFindAndCell(props: .init(names: props.names))
    }
}

private extension FindCityView{
    func viewSetup(){
        addSubview(findAndCell)
    }

    func elementsSetup(){
        findAndCell.layer.cornerRadius = 30
        findAndCell.layer.borderWidth = 1
        findAndCell.layer.borderColor = UIColor.black.cgColor
    }

    func setupConstrains(){
        findAndCell.translatesAutoresizingMaskIntoConstraints = false

        findAndCell.topAnchor.constraint(equalTo: topAnchor, constant: 200).isActive = true
        findAndCell.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -300).isActive = true
        findAndCell.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        findAndCell.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
}
