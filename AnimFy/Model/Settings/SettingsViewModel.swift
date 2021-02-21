//
//  SettingsViewModel.swift
//  AnimFy
//
//  Created by António Bastião on 21.02.21.
//

import Foundation

class SettingsViewModel {

    private var _rows: [SettingsRow]

    init(rows: [SettingsRow]) {
        _rows = rows
    }

    func getRows() -> [SettingsRow] {
        _rows
    }

}
