import Foundation
import Alamofire

class NetworkManager {
    
    private(set) static var baseUrl: String = String()
    
    static var configuration = URLSessionConfiguration.default
    static var serverTrustPolicies = [String: ServerTrustPolicy]()
    
    static private(set) var shared: SessionManager = SessionManager(configuration: configuration, serverTrustPolicyManager: ServerTrustPolicyManager(policies:serverTrustPolicies))
    
    static var additionalHeaders: [NSObject : AnyObject]? {
        didSet {
            if let _ = additionalHeaders {
                configuration.httpAdditionalHeaders = additionalHeaders
            } else {
                configuration.httpAdditionalHeaders = nil
            }
            shared = SessionManager(configuration: configuration, serverTrustPolicyManager: ServerTrustPolicyManager(policies:serverTrustPolicies))
        }
    }
    
    static func setup(baseUrl: String, apiKey: String) {
        NetworkManager.additionalHeaders = [Headers.API_KEY : apiKey] as [NSObject : AnyObject]
        self.baseUrl = baseUrl
    }
}
