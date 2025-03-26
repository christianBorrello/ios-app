import Foundation

extension Date {
    var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }
}
