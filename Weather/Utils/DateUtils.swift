//
//  DateUtils.swift
//  Weather
//
//  Created by Nik on 22.12.2020.
//

import Foundation

class DateUtils {
    
    static func dateFormatterTime(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.string(from: date)
    }
    
    static func convertDateIntToString(_ date: Int, isClearAll: Bool = true) -> String {
        let timeInterval = TimeInterval(date)
        var newDate = Date(timeIntervalSince1970: timeInterval)
        let newHour = Calendar.current.component(.hour, from: newDate)
        newDate = isClearAll ? clearTime(newDate) : setTimeToDate(newDate, hour: newHour, minute: 0, seconds: 0)
        return dateFormatterTime(newDate)
    }

    static func dateTimePicker(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
    
    static func getTimeIntervalDate(_ date: Date?) -> Int {
        return date == nil ? 0 : Int(date!.timeIntervalSince1970)
    }
    
    static func localeShortTime(_ fromDate: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.system
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: fromDate)
    }
    
    static func getTimeString(_ time: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.date(from: time)!
    }
    
    static func getReadableDate(_ date: Date, _ returnToday: String, _ returnTomorrow: String, _ returnYesterday: String) -> String {
        if Calendar.current.isDateInToday(date) {
            return returnToday
        } else if Calendar.current.isDateInTomorrow(date) {
            return returnTomorrow
        } else if Calendar.current.isDateInYesterday(date) {
            return returnYesterday
        } else {
            let dateYear = DateUtils.getParametersCount(date).year!
            let todayYear = DateUtils.getParametersCount(Date()).year!
            let format = dateYear == todayYear ? "MMM d" : "MMM d, yyyy"
            
            return setDateToFormat(date, toFormat: format)!
        }
    }
    
    static func getTimeCalendar(_ date: Date) -> String? {
        return setDateToFormat(date, toFormat: "EE, MMM d")
    }
    
    static func getTimeSync(_ date: Date) -> String? {
        return setDateToFormat(date, toFormat: "EE, MMM d HH:mm")
    }

    static func getDayCalendar(_ date: Date) -> String? {
        return setDateToFormat(date, toFormat: "MMMM d")
    }
    
    static func setDateToFormat(_ date: Date, toFormat: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: toFormat, options: 0, locale:  NSLocale.current)
        dateFormatter.timeZone = NSTimeZone.system
        
        return dateFormatter.string(from: date)
    }
    
    static func clearTime(_ date: Date) -> Date {
        return setTimeToDate(date, hour: 0, minute: 0, seconds: 0)
    }
    
    static func getDateEditMonth(_ date: Date, month: Int) -> Date {
        return Calendar.current.date(byAdding: .month, value: month, to: date)!
    }
    
    static func dateFormatterCalendarDay(_ day: Date, local: String) -> String {
        let dateFormatter = DateFormatter()
        let dateYear = DateUtils.getParametersCount(day).year!
        let todayYear = DateUtils.getParametersCount(Date()).year!
        let format = dateYear == todayYear ? "LLLL" : "LLLL yyyy"

        dateFormatter.locale = Locale(identifier: local)
        dateFormatter.dateStyle = .full
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: day as Date)
    }
    
    static func clearSeconds(_ date: Date) -> Date {
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        return Calendar.current.date(from: dateComponents)!
    }
    
    static func setYearToDate(_ date: Date, year: Int) -> Date {
        var component = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        component.year = year
        return  Calendar.current.date(from: component)!
    }
    
    static func saveDateTo(date: Date, fromDate: Date) -> Date {
        let calendar = Calendar.current
        var newComponents = calendar.dateComponents([.day, .month, .year, .hour, .minute], from: date)
        let components = calendar.dateComponents([.day, .month, .year, .hour, .minute], from: fromDate)
        newComponents.day = components.day
        newComponents.month = components.month
        newComponents.year = components.year
        return calendar.date(from: newComponents)!
    }
    
    static func saveTimeTo(date: Date, fromDate: Date) -> Date {
        let calendar = Calendar.current
        var newComponents = calendar.dateComponents([.day, .month, .year, .hour, .minute], from: date)
        let components = calendar.dateComponents([.day, .month, .year, .hour, .minute], from: fromDate)
        newComponents.hour = components.hour
        newComponents.minute = components.minute
        return calendar.date(from: newComponents)!
    }
    
    static func setDateCalendarParams(year: Int, month: Int, day: Int) -> Date {
        var component = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: Date())
        component.year = year
        component.month = month
        component.day = day
        return Calendar.current.date(from: component)!
    }
    
    static func setTimeToDate(_ date: Date, hour: Int, minute: Int, seconds: Int) -> Date {
        return Calendar.current.date(bySettingHour: hour, minute: minute, second: seconds, of: date)!
    }
    
    static func getParametersCount(_ date: Date) -> DateComponents {
        return Calendar.current.dateComponents([.day, .month, .year, .weekOfYear, .hour, .minute, .second, .nanosecond], from: date)
    }
    
    static func getWeekday() -> Int {
        let calendar = Calendar.current
        calendar.dateComponents([.day, .month, .weekday], from: Date())
        return calendar.firstWeekday
    }
    
    static func getMaxMinDateCalendar(_ minYear: Int, _ maxYear: Int) -> (Date, Date) {
        let minDate = setDateCalendarParams(year: minYear, month: 01, day: 01)
        let maxDate = setDateCalendarParams(year: maxYear, month: 12, day: 31)
        
        return (minDate, maxDate)
    }
    
    static func getHourMinuteDate(_ date: Date) -> (hour: Int, minute: Int) {
        let parametrs = getParametersCount(date)
        return (parametrs.hour ?? 0, parametrs.minute ?? 0)
    }
    
    static func setHourDate(_ date: Date, _ hour: Int) -> Date {
        return setTimeToDate(date, hour: hour, minute: 0, seconds: 0)
    }
    
    static func daysBetween(_ firstDate: Date, _ secondDate: Date) -> Int {
        let calendar = Calendar.current
        // Replace the hour (time) of both dates with 00:00
        let date1 = calendar.startOfDay(for: firstDate)
        let date2 = calendar.startOfDay(for: secondDate)
        
        let components = calendar.dateComponents([.day], from: date1, to: date2)
        return components.day ?? 0
    }
    
    static func getDayOfWeek(_ date: Date) -> Int {
        let calendar = Calendar.current
        var dayOfWeek = calendar.component(.weekday, from: date) + 1 - calendar.firstWeekday
        if dayOfWeek <= 0 {
            dayOfWeek += 7
        }
        return dayOfWeek
    }
    
    static func addYear(_ toDate: Date, years: Int) -> Date {
        return Calendar.current.date(byAdding: .year, value: years, to: toDate)!
    }
    
    static func addMonth(_ toDate: Date, months: Int) -> Date {
        return Calendar.current.date(byAdding: .month, value: months, to: toDate)!
    }
    
    static func addWeek(_ toDate: Date, weeks: Int) -> Date {
        return Calendar.current.date(byAdding: .weekOfMonth, value: weeks, to: toDate)!
    }
    
    static func addDays(_ toDate: Date, days: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: days, to: toDate)!
    }
    
    static func addHours(_ toDate: Date, hours: Int) -> Date {
        return Calendar.current.date(byAdding: .hour, value: hours, to: toDate)!
    }
    
    static func addMinute(_ toDate: Date, minute: Int) -> Date {
        return Calendar.current.date(byAdding: .minute, value: minute, to: toDate)!
    }
}



