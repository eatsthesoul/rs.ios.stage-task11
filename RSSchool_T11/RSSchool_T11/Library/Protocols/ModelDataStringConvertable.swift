//
//  ModelDataStringConvertable.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 5.11.21.
//

import Foundation

protocol ModelDataStringConvertable {
    
    func buildCostString(for initial: Double?) -> String?
    func buildSuccessString(for initial: Double?) -> String?
    func buildDateString(for initial: Date?) -> String?
    func buildMassString(for initial: Mass?) -> String?
    func buildSizeString(for initial: RocketSize?) -> String?
    func buildThrustLevelString(for initial: Thrust?) -> String?
    func buildFuelAmountString(for initial: Double?) -> String?
    func buildBurningTimeString(for initial: Double?) -> String?
    func buildAmountString(for initial: Int?) -> String?
    func buildBoolString(for initial: Bool?) -> String?
}

extension ModelDataStringConvertable {
    
    func buildCostString(for initial: Double?) -> String? {
        let formatter = NumberFormatter()
        guard let initial = initial,
              let valueString = formatter.string(from: NSNumber(value: initial))
        else { return nil }
        return "\(valueString)$"
    }
    
    func buildSuccessString(for initial: Double?) -> String? {
        guard let value = initial else { return nil }
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        let percentageValue = NSNumber(value: value / 100)
        return formatter.string(from: percentageValue)
    }
    
    func buildDateString(for initial: Date?) -> String? {
        guard let date = initial else { return nil }
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        return formatter.string(from: date)
    }
    
    func buildMassString(for initial: Mass?) -> String? {
        initial?.kg != nil ? "\(initial!.kg!.clean) kg" : nil
    }
    
    func buildSizeString(for initial: RocketSize?) -> String? {
        initial?.meters != nil ? "\(initial!.meters!.clean) meters" : nil
    }
    
    func buildThrustLevelString(for initial: Thrust?) -> String? {
        initial?.kN != nil ? "\(initial!.kN!.clean) kN" : nil
    }
    
    func buildFuelAmountString(for initial: Double?) -> String? {
        initial != nil ? "\(initial!.clean) tons" : nil
    }
    
    func buildBurningTimeString(for initial: Double?) -> String? {
        initial != nil ? "\(initial!.clean) seconds" : nil
    }
    
    func buildAmountString(for initial: Int?) -> String? {
        initial != nil ? "\(initial!)" : nil
    }
    
    func buildBoolString(for initial: Bool?) -> String? {
        guard let initial = initial else { return nil }
        return initial ? "Yes" : "No"
    }
}
