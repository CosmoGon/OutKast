//
//  Date+Extension.swift
//  OutKast
//
//  Created by Cosmin Ghinea on 28.11.2024.
//

import Foundation

extension Date {
    func localDate(for timeZone: TimeZone) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.timeZone = timeZone
        return dateFormatter.string(from: self)
    }
    
    func localTime(for timeZone: TimeZone) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        dateFormatter.timeZone = timeZone
        return dateFormatter.string(from: self)
    }
}
