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
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.timeZone = timeZone
        return dateFormatter.string(from: self)
    }
    
    func localWeekDay(for timezone: TimeZone) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        dateFormatter.timeZone = timezone
        return dateFormatter.string(from: self)
    }
}
