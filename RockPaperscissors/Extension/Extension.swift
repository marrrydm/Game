//
//  Extension.swift
//  RockPaperscissors
//
//  Created by Мария Ганеева on 14.10.2023.
//

import UIKit

extension String {
    func localize() -> String {
        return NSLocalizedString(self, comment: "")
    }
}

public extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
