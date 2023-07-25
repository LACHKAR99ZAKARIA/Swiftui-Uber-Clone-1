//
//  RideType.swift
//  uberSwiftUIClone 1
//
//  Created by Zakarai Lachkar on 25/7/2023.
//

import Foundation

enum RideType: Int, CaseIterable, Identifiable {
    case uberX
    case uberBlack
    case uberXl
    var id: Int {return rawValue}
    var description: String {
        switch self {
        case .uberX : return "UberX"
        case .uberBlack : return "uberBlack"
        case .uberXl : return "uberXl"
        }
    }
    var imgName: String {
        switch self {
        case .uberX : return "uber-x"
        case .uberBlack : return "uber-black"
        case .uberXl : return "uber-xl"
        }
    }
    var baseFare: Double {
        switch self {
        case .uberX : return 5
        case .uberBlack : return 20
        case .uberXl : return 10
        }
    }
    func computePrice(for distanceInMeters: Double) -> Double {
        let distanceInMiles = distanceInMeters / 1600
        switch self {
        case .uberX : return distanceInMiles * 1.5 + baseFare
        case .uberBlack : return distanceInMiles * 2.0 + baseFare
        case .uberXl : return distanceInMiles * 1.75 + baseFare
        }
    }
}
