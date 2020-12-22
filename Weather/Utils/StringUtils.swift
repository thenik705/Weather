//
//  StringUtils.swift
//  Weather
//
//  Created by Nik on 20.12.2020.
//

import Foundation
import UIKit

extension String {
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    func isNotEmpty() -> Bool {
        return !self.trim().isEmpty
    }
}

