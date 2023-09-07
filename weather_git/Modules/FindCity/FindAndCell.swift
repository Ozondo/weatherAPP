//
//  FindAndCell.swift
//  weather_git
//
//  Created by Егор Иванов on 14.06.2023.
//

import UIKit

final class FindAndCell: UIView {
    struct Props: Equatable{
        let names: [String]
    }

    private lazy var currentSearchBar = UISearchBar()
    private lazy var currentTableView = UITableView()

    var textChanged: ((String) -> Void)?
    var cellTapped: ((Int) -> Void)?

    private var names: [String] = []

    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        viewSetup()
        elementsSetup()
        constrainsSetup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FindAndCell{
    func uptadeFindAndCell(props: Props){
        names = props.names
        currentTableView.reloadData()
    }
}

private extension FindAndCell{
    func viewSetup(){
        addSubview(currentSearchBar)
        addSubview(currentTableView)
        backgroundColor = .white
    }
    func elementsSetup(){
        currentSearchBar.placeholder = "Search Location"
        currentSearchBar.searchBarStyle = .minimal
        currentSearchBar.tintColor = .black
        currentSearchBar.searchTextField.addAction(
            UIAction{[weak self] _ in
                guard let text = self?.currentSearchBar.text else {return}
                self?.textChanged?(text)
            },
            for: .editingChanged
        )

        currentTableView.backgroundColor = .white
        currentTableView.register(UITableViewCell.self, forCellReuseIdentifier: "id")
        currentTableView.delegate = self
        currentTableView.dataSource = self
    }
    func constrainsSetup(){
        currentSearchBar.translatesAutoresizingMaskIntoConstraints = false
        currentTableView.translatesAutoresizingMaskIntoConstraints = false

        currentSearchBar.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        currentSearchBar.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -90).isActive = true
        currentSearchBar.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        currentSearchBar.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true

        currentTableView.topAnchor.constraint(equalTo: currentSearchBar.bottomAnchor).isActive = true
        currentTableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        currentTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        currentTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
    }
}
extension FindAndCell: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        names.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = currentTableView.dequeueReusableCell(withIdentifier: "id", for: indexPath)
        cell.textLabel?.text = names[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cellTapped?(indexPath.row)
    }
}
