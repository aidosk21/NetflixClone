//
//  Extensions.swift
//  Netflix
//
//  Created by Aidos on 13.01.2023.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
