public enum RomeRoutes: String {
    
    case Assets
    case Clients
    
    public static func url(route: RomeRoutes, params: [String]) -> URL {
        
        var fullUrl : String = NetworkManager.baseUrl + route.rawValue.lowercased()
        
        for param in params {
            fullUrl += "/\(param)"
        }
        
        return URL(string: fullUrl)!
    }
}
