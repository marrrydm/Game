//
//  TabBarController.swift
//  RockPaperscissors
//
//  Created by Мария Ганеева on 14.10.2023.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        self.tabBar.backgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        self.tabBar.tintColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        self.tabBar.barTintColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        self.tabBar.layer.backgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1).cgColor

        let appearance = UITabBarItem.appearance()
        let attributes = [
            NSAttributedString.Key.font:
                UIFont.systemFont(ofSize: 12, weight: .regular),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]

        appearance.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)

        let attributesSelected = [
            NSAttributedString.Key.font:
                UIFont.systemFont(ofSize: 12, weight: .regular),
            NSAttributedString.Key.foregroundColor: UIColor(red: 0.996, green: 0.8, blue: 0.376, alpha: 1)
        ]

        appearance.setTitleTextAttributes(attributesSelected as [NSAttributedString.Key : Any], for: .selected)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let gameController = UINavigationController(rootViewController: StartGameController())
        gameController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        gameController.navigationBar.shadowImage = UIImage()
        gameController.navigationBar.isTranslucent = true
        let gameControllerItem = UITabBarItem(title: "tabbar.game".localize(), image: UIImage(named: "game")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "game_selected")?.withRenderingMode(.alwaysOriginal))

        gameController.tabBarItem = gameControllerItem

        let resultController = ResultController()
        let resultControllerItem = UITabBarItem(title: "tabbar.result".localize(), image: UIImage(named: "result")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "result_selected")?.withRenderingMode(.alwaysOriginal))

        resultController.tabBarItem = resultControllerItem

        self.viewControllers = [gameController, resultController]
    }
}
