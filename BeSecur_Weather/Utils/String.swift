//
//  String.swift
//  BeSecur_Weather
//
//  Created by Sheerien Manzoor on 8/27/19.
//  Copyright © 2019 Muhammad Shahrukh. All rights reserved.
//

import UIKit

extension String {
    
    func getDayOfWeek() -> String {
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let formattedDate = formatter.date(from: self) else { return ""}
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: formattedDate)
        let weekDayName = weekDay.getWeekDayName()
        return weekDayName
    }
    
    func isTheDayToday() -> Bool {
        let today = Calendar.current.component(.weekday, from: Date())
        let todayName = today.getWeekDayName()
        if self == todayName {
            return true
        } else {
            return false
        }
    }
    
    func istheDateToday() -> Bool {
        let date = self.createDateFromShortString()
        let answer = Calendar.current.isDateInToday(date)
        if answer {
            return true
        } else {
            return false
        }
    }
    
    func istheHourNow() -> Bool {
        let currentHour = Calendar.current.component(.hour, from: Date())
        if currentHour == self.createHourFromDateString() {
            return true
        } else {
            return false
        }
    }
    
    func createDateFromShortString() -> Date {
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = formatter.date(from: self)!
        return formattedDate
    }
    
    func createDateFromLongString() -> Date {
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let formattedDate = formatter.date(from: self)!
        return formattedDate
    }
    
    func formatStringToDateType() -> String {
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let formattedDate = formatter.date(from: self) else { return ""}
        formatter.dateFormat = "yyyy/MM/dd"
        let dateString = formatter.string(from: formattedDate)
        return dateString
    }
    
    func createHourFromDateString() -> Int {
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        guard let formattedDate = formatter.date(from: self) else { return 0 }
        let hour = Calendar.current.component(.hour, from: formattedDate)
        return hour
    }
}

extension NSMutableAttributedString {
    
    class func setupWithText(_ text: String, description: String, textFont: UIFont, descriptionFont: UIFont, textColor: UIColor, descriptionColor: UIColor) -> NSMutableAttributedString? {
        
        let textAttribute = [NSAttributedString.Key.font: textFont, NSAttributedString.Key.foregroundColor: textColor] 
        let descriptionAttribute = [NSAttributedString.Key.font: descriptionFont, NSAttributedString.Key.foregroundColor: descriptionColor]
        
        let attributedText = NSMutableAttributedString(string: text, attributes: textAttribute)
        let descriptionAttributedString = NSMutableAttributedString(string: description, attributes:  descriptionAttribute)
        attributedText.append(descriptionAttributedString)
        return attributedText
    }

}
