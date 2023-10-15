//
//  ResultController.swift
//  RockPaperscissors
//
//  Created by Мария Ганеева on 14.10.2023.
//

import UIKit

class ResultController: UIViewController {
    private let bgImg: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "background")
        view.contentMode = .scaleToFill

        return view
    }()

    private let labelTitle: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.text = "result.title".localize()
        view.font = .systemFont(ofSize: 28, weight: .bold)
        view.numberOfLines = 0
        view.textAlignment = .left
        view.lineBreakMode = .byWordWrapping

        return view
    }()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.showsVerticalScrollIndicator = false
        view.register(ResultCell.self, forCellWithReuseIdentifier: ResultCell.id)

        return view
    }()

    private var resultCells: [ResultModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setupViews()
        makeConstraints()

        collectionView.dataSource = self
        collectionView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let saved = UserDefaults.standard.object(forKey: UserData.SettingsKeys.resultData.rawValue) as? Data {
            let decoder = JSONDecoder()
            if let item = try? decoder.decode([ResultModel].self, from: saved) {
                resultCells = item
            } else {
                resultCells = UserData.resultData!
            }
        }
        collectionView.reloadData()
    }
}

private extension ResultController {
    func setupViews() {
        view.addSubviews(bgImg, labelTitle, collectionView)
    }

    func makeConstraints() {
        bgImg.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bgImg.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bgImg.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bgImg.topAnchor.constraint(equalTo: view.topAnchor),
            bgImg.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            labelTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            labelTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10)
        ])

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            collectionView.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 10),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension ResultController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resultCells.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultCell.id, for: indexPath) as! ResultCell
        cell.setup(data: resultCells[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width - 16, height: 100)
    }
}
