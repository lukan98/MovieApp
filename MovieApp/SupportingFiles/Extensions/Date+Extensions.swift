import Foundation

extension Date {

    var uiShortDate: String {
        toDateString(with: "dd/MM/yyyy")
    }

    var uiLongDate: String {
        toDateString(with: "MMMM dd, yyyy")
    }

    var uiYear: String {
        "(" + toDateString(with: "yyyy") + ")"
    }

    init?(serverDate: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let date = formatter.date(from: serverDate) else { return nil }

        self = date
    }

    init?(iso8601Date: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        guard let date = formatter.date(from: iso8601Date) else { return nil }

        self = date
    }

    func toDateString(with template: String) -> String {
        let format = DateFormatter()
        format.locale = .current
        format.timeStyle = .none
        format.setLocalizedDateFormatFromTemplate(template)
        return format.string(from: self)
    }
    
}
