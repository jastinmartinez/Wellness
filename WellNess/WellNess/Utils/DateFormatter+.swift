import Foundation

extension DateFormatter {
    static let medium: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .medium
        df.timeStyle = .short
        return df
    }()
}
