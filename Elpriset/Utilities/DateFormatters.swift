import Foundation

enum DateFormatters {
    static let swedish: Locale = Locale(identifier: "sv_SE")
    static let timeZoneSE: TimeZone = TimeZone(identifier: "Europe/Stockholm")!

    static let timeShort: DateFormatter = {
        let f = DateFormatter()
        f.locale = swedish
        f.timeZone = timeZoneSE
        f.dateFormat = "HH:mm"
        return f
    }()

    static let dateShort: DateFormatter = {
        let f = DateFormatter()
        f.locale = swedish
        f.timeZone = timeZoneSE
        f.dateFormat = "d MMM"
        return f
    }()

    static let dateFull: DateFormatter = {
        let f = DateFormatter()
        f.locale = swedish
        f.timeZone = timeZoneSE
        f.dateFormat = "EEEE, d MMMM"
        return f
    }()

    static let dayOfWeek: DateFormatter = {
        let f = DateFormatter()
        f.locale = swedish
        f.timeZone = timeZoneSE
        f.dateFormat = "EEEE, d MMM"
        return f
    }()

    static let monthYear: DateFormatter = {
        let f = DateFormatter()
        f.locale = swedish
        f.timeZone = timeZoneSE
        f.dateFormat = "MMMM yyyy"
        return f
    }()

    static let apiPath: DateFormatter = {
        let f = DateFormatter()
        f.locale = Locale(identifier: "en_US_POSIX")
        f.timeZone = timeZoneSE
        f.dateFormat = "yyyy/MM'-'dd"
        return f
    }()
}
