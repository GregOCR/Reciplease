//
//  String+Localized.swift
//  Reciplease
//
//  Created by Greg on 18/11/2021.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
