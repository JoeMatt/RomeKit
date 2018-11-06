import Foundation

class FileHelpers {
    
    static func loadJSONStringFromFile(name: String) -> String? {
        
        if let path = Bundle(for: self).url(forResource: name, withExtension: ".json") {
            if let data = try? Data(contentsOf: path) {
                return String(data: data, encoding:String.Encoding.utf8)
            }
        }
        
        return nil
    }
    
    static func loadZipDataFromFile(name: String) -> Data? {
        
        if let path = Bundle(for: self).url(forResource: name, withExtension: ".zip") {
            if let data = try? Data(contentsOf: path) {
                return data
            }
        }
        
        return nil
        
    }
}
