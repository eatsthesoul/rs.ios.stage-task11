//
//  RocketDataDisplayable.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 4.11.21.
//

import Foundation

protocol RocketDataDisplayable {
    
    func buildCostString(for rocket: Rocket) -> String
    func buildSuccessString(for rocket: Rocket) -> String
    func buildLaunchString(for rocket: Rocket) -> String?
    func buildMassString(for rocket: Rocket) -> String
    func buildHeightString(for rocket: Rocket) -> String
    func buildDiameterString(for rocket: Rocket) -> String
    func buildThrustLevel(for rocket: Rocket, thrustType: ThrustType) -> String
    func buildFuelAmountString(for rocket: Rocket, stage: RocketStageType) -> String
}

enum RocketStageType {
    case first
    case second
}

enum ThrustType {
    case seaLevel
    case vacuum
    case thrust
}

extension RocketDataDisplayable {
    
    private var voidPlaceholder: String { "Unknown" }
    
    func buildCostString(for rocket: Rocket) -> String {
        let formatter = NumberFormatter()
        formatter.currencySymbol = ""
        formatter.currencyDecimalSeparator = ""
        formatter.maximumFractionDigits = 0
        formatter.minimumFractionDigits = 0
        formatter.currencyGroupingSeparator = ""
        
        return "\(formatter.string(from: NSNumber(value: rocket.launchCost ?? .zero)) ?? "")$"
    }
    
    func buildSuccessString(for rocket: Rocket) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        let value = NSNumber(value: Double(rocket.success ?? 0) / 100)
        return formatter.string(from: value) ?? voidPlaceholder
    }
    
    func buildLaunchString(for rocket: Rocket) -> String? {
        guard let date = rocket.firstLaunch else {
            return voidPlaceholder
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        return formatter.string(from: date)
    }
    
    func buildMassString(for rocket: Rocket) -> String {
        guard let value = rocket.mass?.kg else { return voidPlaceholder }
        return "\(value) kg"
    }
    
    func buildHeightString(for rocket: Rocket) -> String {
        guard let value = rocket.height?.meters else { return voidPlaceholder }
        return ("\(value) meters")
    }
    
    func buildDiameterString(for rocket: Rocket) -> String {
        guard let value = rocket.diameter?.meters else { return voidPlaceholder }
        return ("\(value) meters")
    }
    
    func buildThrustLevel(for rocket: Rocket, thrustType: ThrustType) -> String {
        var value: Double? = nil
        switch thrustType {
        case .seaLevel:
            value = rocket.firstStage.thrustSeaLevel?.kN
        case .vacuum:
            value = rocket.firstStage.thrustVacuum?.kN
        case .thrust:
            value = rocket.secondStage.thrust?.kN
        }
        return value != nil ? "\(value!) kN" : voidPlaceholder
    }
    
    func buildFuelAmountString(for rocket: Rocket, stage: RocketStageType) -> String {
        var value: Double? = nil
        switch stage {
        case .first:
            value = rocket.firstStage.fuelAmount
        case .second:
            value = rocket.secondStage.fuelAmount
        }
        return value != nil ? "\(value!) tons" : voidPlaceholder
    }
}
