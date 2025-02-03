import Foundation

struct DateFormatterUtil {
    // MARK: - 날짜 변환 함수 (YYYYMMDD → YYYY-MM-DD)
    static func formatDateString(_ dateString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyyMMdd"
        guard let date = inputFormatter.date(from: dateString) else { return dateString }

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "yyyy-MM-dd"
        return outputFormatter.string(from: date)
    }
}
