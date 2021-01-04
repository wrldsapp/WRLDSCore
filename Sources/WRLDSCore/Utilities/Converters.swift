//
//  Converters.swift
//  WRLDS
//
//  Created by Gillian Reynolds-Titko on 5/25/20.
//  Copyright © 2020 WRLDS. All rights reserved.
//
import Foundation

public struct Converters {
    
    //convert timeinterval to date
    let dateGenerator: () -> Date
    
    public init(dateGenerator: @escaping () -> Date = Date.init) {
        self.dateGenerator = dateGenerator
    }

    
    public func convert(fromCents: Int?) -> Double? {
        guard let cents = fromCents else {
            return nil
        }
        return Double(cents)/100.0
    }
    
    public func formatDouble(toCurrency: Double) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current //Keep for future state to add locale
        formatter.numberStyle = .currency
        if let formattedAmount = formatter.string(from:toCurrency as NSNumber) {
            return formattedAmount
        } else {

            return ""
        }
    }
    
    public func convertFromTimestamp(toDate: TimeInterval) -> Date {
        return Date(timeIntervalSince1970: toDate)
    }
    
    
    
    public static func getStringFrom(_ int: Int) -> String {
        
        typealias Abbreviation = (threshold: Double, divisor: Double, suffix: String)
        
        let numFormatter = NumberFormatter()
        let abbreviations: [Abbreviation] = [
            (0,1,""),
            (10_000.0, 1000.0, "K"),
            (1_000_000.0, 1_000_000.0,"M"),
            (1_000_000_000.0, 1_000_000_000.0, "B")
        ]
        
        let initialValue = Double(abs(int))
        
        let abbreviation: Abbreviation = {
            var prev = abbreviations[0]
            for a in abbreviations {
                if initialValue < a.threshold {
                    break
                }
                prev = a
            }
            return prev
        }()
        
        let value = Double(int) / abbreviation.divisor
        numFormatter.positiveSuffix = abbreviation.suffix
        numFormatter.negativePrefix = abbreviation.suffix
        numFormatter.allowsFloats = true
        numFormatter.minimumIntegerDigits = 1
        numFormatter.minimumFractionDigits = 0
        numFormatter.maximumFractionDigits = 1
        return numFormatter.string(from: NSNumber(value: value))!
    }
}
