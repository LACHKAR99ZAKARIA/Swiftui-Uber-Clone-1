//
//  Double.swift
//  uberSwiftUIClone 1
//
//  Created by Zakarai Lachkar on 25/7/2023.
//

import Foundation

extension Double {
    private var currencyFormatted : NumberFormatter {
        let formatted = NumberFormatter()
        formatted.numberStyle = .currency
        formatted.minimumFractionDigits = 2
        formatted.maximumFractionDigits = 2
        return formatted
    }
    func toCurrency() -> String {
        return currencyFormatted.string(for: self) ?? ""
    }
}
