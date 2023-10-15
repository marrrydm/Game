//
//  StartGameController.swift
//  RockPaperscissors
//
//  Created by Мария Ганеева on 14.10.2023.
//

import UIKit

class StartGameController: UIViewController {
    private let bgImg: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "background")
        view.contentMode = .scaleToFill

        return view
    }()

    private let labelTitle: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.text = "game.title.1".localize()
        view.font = .systemFont(ofSize: 28, weight: .bold)
        view.numberOfLines = 0
        view.textAlignment = .left
        view.lineBreakMode = .byWordWrapping

        return view
    }()

    private let contentLabel: UILabel = {
        let view = UILabel()
        view.text = "game.content.1".localize()
        view.textColor = .white
        view.font = .systemFont(ofSize: 20, weight: .medium)
        view.numberOfLines = 0
        view.textAlignment = .left
        view.lineBreakMode = .byWordWrapping

        return view
    }()

    private let imgView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "imgStart")
        view.contentMode = .scaleAspectFit

        return view
    }()

    private lazy var nextButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = UIColor(red: 0.996, green: 0.8, blue: 0.376, alpha: 1)
        view.setTitle("startBtn".localize(), for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        view.contentVerticalAlignment = .center
        view.layer.cornerRadius = 20
        view.alpha = 0.4
        view.addTarget(self, action: #selector(tapButtonNext), for: .touchUpInside)

        return view
    }()

    private lazy var nameTextView: UITextField = {
        let view = UITextField()
        view.backgroundColor = UIColor(red: 0.267, green: 0.267, blue: 0.275, alpha: 1)
        view.layer.cornerRadius = 10
        view.text = "name.enter".localize()
        view.layer.sublayerTransform = CATransform3DMakeTranslation(12, 0, 0)
        view.textColor = UIColor(red: 0.922, green: 0.922, blue: 0.961, alpha: 0.6)
        view.keyboardType = .default

        return view
    }()

    private var name: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setupViews()
        makeConstraints()
        setupDoneBtn()

        nameTextView.delegate = self
    }
}

private extension StartGameController {
    func setupViews() {
        view.addSubviews(bgImg, imgView, labelTitle, contentLabel, nextButton, nameTextView)
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

        nameTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            nameTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            nameTextView.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 8),
            nameTextView.heightAnchor.constraint(equalToConstant: 44)
        ])

        nextButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            nextButton.heightAnchor.constraint(equalToConstant: 48)
        ])

        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            contentLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            contentLabel.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 10)
        ])

        imgView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imgView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imgView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imgView.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -10)
        ])
    }
}

extension StartGameController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.textColor == UIColor(red: 0.922, green: 0.922, blue: 0.961, alpha: 0.6) {
            textField.text = nil
            textField.textColor = .white
        }

        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(red: 0.996, green: 0.8, blue: 0.376, alpha: 1).cgColor
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text!.isEmpty || (textField.text == "name.enter".localize()) {
            textField.text = "name.enter".localize()
            textField.textColor = UIColor(red: 0.922, green: 0.922, blue: 0.961, alpha: 0.6)
            nextButton.alpha = 0.4
        } else {
            name = textField.text
            nextButton.alpha = 1
        }

        textField.layer.borderWidth = 0
    }
}

private extension StartGameController {
    @objc func tapButtonNext(sender: UITapGestureRecognizer) {
        if nextButton.alpha == 1 {
            let vc = GameController()
            vc.name = name
            navigationController?.pushViewController(vc, animated: false)

            nameTextView.text = "name.enter".localize()
            nextButton.alpha = 0.4
        }
    }

    func setupDoneBtn() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "Done".localize(), style: .done, target: self, action: #selector(hideKeyboard))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        nameTextView.inputAccessoryView = toolBar
    }

    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}
