import Foundation

class FileHelpers {
    
    static func loadJSONStringFromFile(name: String) -> String? {
        
        if let path = NSBundle(forClass: self).pathForResource(name, ofType: ".json") {
            if let data = Data(contentsOfFile: path) {
                return String(data: data, encoding:NSUTF8StringEncoding)
            }
        }
        
        return nil
        
    }
    
    static func loadZipDataFromFile(name: String) -> Data? {
        
        if let path = NSBundle(forClass: self).pathForResource(name, ofType: ".zip") {
            if let data = Data(contentsOfFile: path) {
                return data
            }
        }
        
        return nil
        
    }
    
}
