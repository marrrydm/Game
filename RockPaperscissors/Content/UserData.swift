//
//  UserData.swift
//  RockPaperscissors
//
//  Created by Мария Ганеева on 14.10.2023.
//

import Foundation

final class UserData {
    public enum SettingsKeys: String, CaseIterable {
        case resultData
    }

    static var resultData: [ResultModel]? {
        get {
            if let saved = UserDefaults.standard.object(forKey: SettingsKeys.resultData.rawValue) as? Data {
                let decoder = JSONDecoder()
                if let item = try? decoder.decode([ResultModel].self, from: saved) {
                    return item
                }
            }
            return []
        }
    }
}
