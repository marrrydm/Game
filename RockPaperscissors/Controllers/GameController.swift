//
//  GameController.swift
//  RockPaperscissors
//
//  Created by Мария Ганеева on 14.10.2023.
//

import UIKit

class GameController: UIViewController {
    private let bgImg: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "background")
        view.contentMode = .scaleToFill

        return view
    }()

    private let labelTitle: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.text = "game.title.2".localize()
        view.font = .systemFont(ofSize: 28, weight: .bold)
        view.numberOfLines = 0
        view.textAlignment = .left
        view.lineBreakMode = .byWordWrapping

        return view
    }()

    private let timeLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = .systemFont(ofSize: 77, weight: .bold)
        view.numberOfLines = 0
        view.textAlignment = .left
        view.lineBreakMode = .byWordWrapping

        return view
    }()

    private let stackView: UIStackView = {
        let view = UIStackView()
        view.backgroundColor = .clear
        view.axis = .horizontal
        view.alignment = .fill
        view.distribution = .fillEqually
        view.spacing = 16

        return view
    }()

    private lazy var imgView1: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "stone")
        view.contentMode = .scaleAspectFit
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapUser)))

        return view
    }()

    private lazy var imgView2: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "scissors")
        view.contentMode = .scaleAspectFit
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapUser)))

        return view
    }()

    private lazy var imgView3: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "paper")
        view.contentMode = .scaleAspectFit
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapUser)))

        return view
    }()

    private lazy var button1: UIButton = {
        let view = UIButton()
        view.layer.cornerRadius = 8
        view.backgroundColor = .clear
        view.addTarget(self, action: #selector(tapUser), for: .touchUpInside)

        return view
    }()

    private lazy var button2: UIButton = {
        let view = UIButton()
        view.layer.cornerRadius = 8
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = true
        view.addTarget(self, action: #selector(tapUser), for: .touchUpInside)

        return view
    }()

    private lazy var button3: UIButton = {
        let view = UIButton()
        view.layer.cornerRadius = 8
        view.backgroundColor = .clear
        view.addTarget(self, action: #selector(tapUser), for: .touchUpInside)

        return view
    }()

    private let imgViewVS1: UIImageView = {
        let view = UIImageView()
        view.image = UIImage()
        view.contentMode = .scaleAspectFit
        view.isUserInteractionEnabled = true
        view.isHidden = true

        return view
    }()

    private let imgViewVS2: UIImageView = {
        let view = UIImageView()
        view.image = UIImage()
        view.contentMode = .scaleAspectFit
        view.isUserInteractionEnabled = true
        view.isHidden = true

        return view
    }()

    private let VS1Title: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.text = "Dealer".localize()
        view.font = .systemFont(ofSize: 16, weight: .regular)
        view.numberOfLines = 0
        view.textAlignment = .center
        view.lineBreakMode = .byWordWrapping
        view.isHidden = true

        return view
    }()

    private let VS2Title: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.text = "Your choice".localize()
        view.font = .systemFont(ofSize: 16, weight: .regular)
        view.numberOfLines = 0
        view.textAlignment = .center
        view.lineBreakMode = .byWordWrapping
        view.isHidden = true

        return view
    }()

    private let chooseTitle: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)
        view.text = "game.choose".localize()
        view.font = .systemFont(ofSize: 16, weight: .regular)
        view.numberOfLines = 0
        view.textAlignment = .center
        view.lineBreakMode = .byWordWrapping

        return view
    }()

    private lazy var nextButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = UIColor(red: 0.996, green: 0.8, blue: 0.376, alpha: 1)
        view.setTitle("btn.result".localize(), for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        view.contentVerticalAlignment = .center
        view.layer.cornerRadius = 20
        view.addTarget(self, action: #selector(tapButtonNext), for: .touchUpInside)
        view.isHidden = true

        return view
    }()

    private let arrayItems = ["stone", "scissors", "paper"]
    private var circleCount = 1
    private var resultCount = 0
    private var resultOpponentCount = 0
    private var timer: Timer?
    private var timeLeft = 4
    var name: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setupViews()
        makeConstraints()

        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
    }
}

private extension GameController {
    func setupViews() {
        view.addSubviews(bgImg, stackView, labelTitle, timeLabel, chooseTitle)
        view.addSubviews(nextButton, VS1Title, VS2Title, imgViewVS1, imgViewVS2)
        stackView.addArrangedSubview(imgView1)
        stackView.addArrangedSubview(imgView2)
        stackView.addArrangedSubview(imgView3)
        imgView1.addSubview(button1)
        imgView2.addSubview(button2)
        imgView3.addSubview(button3)
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

        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            timeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 200),
            stackView.heightAnchor.constraint(equalToConstant: 250)
        ])

        button1.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button1.centerYAnchor.constraint(equalTo: imgView1.centerYAnchor),
            button1.centerXAnchor.constraint(equalTo: imgView1.centerXAnchor),
            button1.heightAnchor.constraint(equalTo: imgView1.heightAnchor),
            button1.widthAnchor.constraint(equalTo: imgView1.widthAnchor)
        ])

        button2.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button2.centerYAnchor.constraint(equalTo: imgView2.centerYAnchor),
            button2.centerXAnchor.constraint(equalTo: imgView2.centerXAnchor),
            button2.heightAnchor.constraint(equalTo: imgView2.heightAnchor),
            button2.widthAnchor.constraint(equalTo: imgView2.widthAnchor)
        ])

        button3.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button3.centerYAnchor.constraint(equalTo: imgView3.centerYAnchor),
            button3.centerXAnchor.constraint(equalTo: imgView3.centerXAnchor),
            button3.heightAnchor.constraint(equalTo: imgView3.heightAnchor),
            button3.widthAnchor.constraint(equalTo: imgView3.widthAnchor)
        ])

        chooseTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            chooseTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            chooseTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            chooseTitle.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])

        nextButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            nextButton.heightAnchor.constraint(equalToConstant: 48)
        ])

        VS1Title.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            VS1Title.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 40),
            VS1Title.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        imgViewVS1.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imgViewVS1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imgViewVS1.topAnchor.constraint(equalTo: VS1Title.bottomAnchor, constant: 12),
            imgViewVS1.heightAnchor.constraint(equalToConstant: 100),
            imgViewVS1.widthAnchor.constraint(equalToConstant: 100)
        ])

        imgViewVS2.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imgViewVS2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imgViewVS2.topAnchor.constraint(equalTo: imgViewVS1.bottomAnchor, constant: 30),
            imgViewVS2.heightAnchor.constraint(equalToConstant: 100),
            imgViewVS2.widthAnchor.constraint(equalToConstant: 100)
        ])

        VS2Title.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            VS2Title.topAnchor.constraint(equalTo: imgViewVS2.bottomAnchor, constant: 12),
            VS2Title.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

extension GameController {
    @objc private func tapUser(sender: UIButton) {
        switch (sender) {
        case button1:
            imgView1.image = UIImage(named: "selectStone")
            imgView2.image = UIImage(named: "scissors")
            imgView3.image = UIImage(named: "paper")
            imgViewVS2.image = UIImage(named: "stone")
            imgViewVS1.image = UIImage(named: arrayItems.randomElement() ?? "scissors")
            chooseTitle.isHidden = true
        case button2:
            imgView1.image = UIImage(named: "stone")
            imgView2.image = UIImage(named: "selectScissors")
            imgView3.image = UIImage(named: "paper")
            imgViewVS2.image = UIImage(named: "scissors")
            imgViewVS1.image = UIImage(named: arrayItems.randomElement() ?? "paper")
            chooseTitle.isHidden = true
        case button3:
            imgView1.image = UIImage(named: "stone")
            imgView2.image = UIImage(named: "scissors")
            imgView3.image = UIImage(named: "selectPaper")
            imgViewVS2.image = UIImage(named: "paper")
            imgViewVS1.image = UIImage(named: arrayItems.randomElement() ?? "stone")
            chooseTitle.isHidden = true
        default: break
        }
    }

    @objc private func tapButtonNext(sender: UITapGestureRecognizer) {
        stackView.isUserInteractionEnabled = true
        stackView.isHidden = false
        nextButton.isHidden = true
        VS1Title.isHidden = true
        VS2Title.isHidden = true
        imgViewVS1.image = UIImage()
        imgViewVS1.isHidden = true
        imgViewVS2.isHidden = true
        imgView1.image = UIImage(named: "stone")
        imgView2.image = UIImage(named: "scissors")
        imgView3.image = UIImage(named: "paper")
        chooseTitle.isHidden = false
        timeLeft = 4
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
        nextButton.setTitle("btn.result".localize(), for: .normal)
    }
}

extension GameController {
    @objc func onTimerFires() {
        if circleCount >= 6 || resultCount == 3 || resultOpponentCount == 3 && (resultCount != resultOpponentCount) {
            timer?.invalidate()
            timer = nil

            saveResult()
            nextButton.setTitle("btn.result".localize(), for: .normal)
            navigationController?.popViewController(animated: false)
        } else {
            timeLeft -= 1
            timeLabel.text = "\(timeLeft)"

            if timeLeft <= 1 {
                timeLabel.text = "1"
            }

            if timeLeft <= 0 && imgViewVS1.image != UIImage() {
                timeLabel.text = ""
                timer?.invalidate()
                timer = nil
                circleCount += 1

                stackView.isUserInteractionEnabled = false
                VS1Title.isHidden = false
                VS2Title.isHidden = false
                imgViewVS1.isHidden = false
                imgViewVS2.isHidden = false
                nextButton.isHidden = false
                stackView.isHidden = true

                switch imgViewVS1.image {
                case UIImage(named: "stone"):
                    if imgViewVS2.image == UIImage(named: "paper") {
                        resultCount += 1
                    } else if imgViewVS2.image != imgViewVS1.image {
                        resultOpponentCount += 1
                    }
                case UIImage(named: "scissors"):
                    if imgViewVS2.image == UIImage(named: "stone") {
                        resultCount += 1
                    } else if imgViewVS2.image != imgViewVS1.image {
                        resultOpponentCount += 1
                    }
                case UIImage(named: "paper"):
                    if imgViewVS2.image == UIImage(named: "scissors") {
                        resultCount += 1
                    } else if imgViewVS2.image != imgViewVS1.image {
                        resultOpponentCount += 1
                    }
                default: break
                }
            }
        }
    }
}

// MARK: - Save Results
private extension GameController {
    func saveResult() {
        var resultArray = [ResultModel]()
        guard let name = name else { return }
        var newVal = ResultModel(name: "", countWin: 0, score: 0)

        if let saved = UserDefaults.standard.object(forKey: UserData.SettingsKeys.resultData.rawValue) as? Data {
            let decoder = JSONDecoder()
            if let item = try? decoder.decode([ResultModel].self, from: saved) {
                resultArray = item
            }
        }

        newVal = resultCount > resultOpponentCount ? ResultModel(name: name, countWin: 1, score: resultCount) : ResultModel(name: name, countWin: 0, score: resultCount)
        if resultCount != resultOpponentCount { resultArray.append(newVal) }

        if let encoded = try? JSONEncoder().encode(resultArray) {
            UserDefaults.standard.set(encoded, forKey: UserData.SettingsKeys.resultData.rawValue)
        }
    }
}
