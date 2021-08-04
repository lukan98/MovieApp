import Foundation

extension Date {

    var year: Int {
        let components = Calendar.current.dateComponents([.year], from: self)
        let year = components.year ?? .zero
        return year
    }

    func toDateString(with template: String) -> String {
        let format = DateFormatter()
        format.locale = .current
        format.timeStyle = .none
        format.setLocalizedDateFormatFromTemplate(template)
        return format.string(from: self)
    }
    
}
