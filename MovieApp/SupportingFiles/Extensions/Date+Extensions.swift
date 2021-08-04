import Foundation

extension Date {

    var uiDate: String {
        toDateString(with: "dd/MM/yyyy")
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

    func toDateString(with template: String) -> String {
        let format = DateFormatter()
        format.locale = .current
        format.timeStyle = .none
        format.setLocalizedDateFormatFromTemplate(template)
        return format.string(from: self)
    }
    
}
