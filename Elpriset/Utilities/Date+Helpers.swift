import Foundation

extension Date {
    static var stockholm: TimeZone {
        TimeZone(identifier: "Europe/Stockholm")!
    }

    var startOfDayStockholm: Date {
        var cal = Calendar.current
        cal.timeZone = Self.stockholm
        return cal.startOfDay(for: self)
    }

    var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }

    var isTomorrow: Bool {
        Calendar.current.isDateInTomorrow(self)
    }

    var hour: Int {
        var cal = Calendar.current
        cal.timeZone = Self.stockholm
        return cal.component(.hour, from: self)
    }

    var minute: Int {
        var cal = Calendar.current
        cal.timeZone = Self.stockholm
        return cal.component(.minute, from: self)
    }

    var isNighttime: Bool {
        let h = hour
        return h >= 22 || h < 6
    }

    func addingDays(_ days: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: days, to: self)!
    }
}
