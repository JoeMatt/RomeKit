import Foundation
import ObjectMapper

public class ISO8601MilliSecondsDateTransform: DateFormatterTransform {
    public init() {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        super.init(dateFormatter: formatter)
    }
}
