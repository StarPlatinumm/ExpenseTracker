//
//  Extensions.swift
//  ExpenseTracker
//
//  Created by Артем Кривдин on 25.12.2022.
//

import SwiftUI


extension Color {
    static let background = Color("Background")
    static let icon = Color("Icon")
    static let text = Color("Text")
    static let systemBackground = Color(uiColor: .systemBackground)
}

extension DateFormatter {
    static let allNumericUSA: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter
    }()
}

extension String {
    func dateParced() -> Date {
        guard let parcedDate = DateFormatter.allNumericUSA.date(from: self) else { return Date() }
        
        return parcedDate
    }
}

extension Date {
    func formatted() -> String {
        return self.formatted(.dateTime.year().month().day())
    }
}

extension Double {
    func roudedTo2Digits() -> Double {
        return (self * 100).rounded() / 100
    }
}
