//
//  ResultCell.swift
//  RockPaperscissors
//
//  Created by Мария Ганеева on 15.10.2023.
//

import UIKit

class ResultCell: UICollectionViewCell {
    static let id = "Cell"

    private let nameLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 14, weight: .bold)
        view.textColor = .white
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping

        return view
    }()

    private let countWinLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 14, weight: .medium)
        view.textAlignment = .left
        view.textColor = .white

        return view
    }()

    private let scoreLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 14, weight: .medium)
        view.textAlignment = .left
        view.textColor = .white

        return view
    }()

    func setup(data: ResultModel) {
        setupViews()
        makeConstraints()

        nameLabel.text = data.name
        countWinLabel.text = "win.label".localize() + " \(data.countWin)"
        scoreLabel.text = "score".localize() + " \(data.score)"

        backgroundColor = UIColor(red: 0.227, green: 0.227, blue: 0.235, alpha: 1)
        layer.cornerRadius = 14
    }
}

private extension ResultCell {
    func setupViews() {
        addSubviews(nameLabel, countWinLabel, scoreLabel)
    }

    func makeConstraints() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            nameLabel.bottomAnchor.constraint(equalTo: countWinLabel.topAnchor, constant: -10)
        ])

        countWinLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            countWinLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            countWinLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])

        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scoreLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            scoreLabel.topAnchor.constraint(equalTo: countWinLabel.bottomAnchor, constant: 10)
        ])
    }
}
