import Foundation
import Dispatch
import Alamofire
import ObjectMapper

public class Clients {
    
    public static func all(
        queue: DispatchQueue? = nil,
        completionHandler: @escaping ([Client]?, Errors?) -> ()) {
        
        let url = RomeRoutes.url(route: .Clients, params: [])

        NetworkManager.shared.request(url).responseString(queue: queue) { response in
            
            switch response.result {
            case .success(let clientsJSON):
                if let clients = Mapper<Client>().mapArray(JSONObject: clientsJSON) {
                    completionHandler(clients, nil)
                } else {
                    completionHandler(nil, Errors.ErrorMappingClients)
                }
            case .failure:
                completionHandler(nil, Errors.errorTypeFromResponse(response: response.response))
            }
            
        }
        
    }
    
    public static func create(
        name: String,
        queue: DispatchQueue? = nil,
        completionHandler: @escaping (Client?, Errors?) -> ()) {
        
        let url = RomeRoutes.url(route: .Clients, params: [])
        let params = ["name": name]
        
        NetworkManager.shared.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseString(queue: queue) { response in
            
            switch response.result {
            case .success(let clientJSON):
                if let client = Mapper<Client>().map(JSONObject: clientJSON) {
                    completionHandler(client, nil)
                } else {
                    completionHandler(nil, Errors.ErrorMappingClients)
                }
            case .failure:
                completionHandler(nil, Errors.errorTypeFromResponse(response: response.response))
            }
            
        }
    }
    
    public static func delete(
        id: String,
        queue: DispatchQueue? = nil,
        completionHandler: @escaping (Bool?, Errors?) -> ()) {
        
        let url = RomeRoutes.url(route: .Clients, params: [id])
        
        NetworkManager.shared.request(url, method: .delete, parameters: nil, encoding: URLEncoding.default, headers: nil).responseString(queue: queue) { response in
            
            switch response.result {
            case .success:
                completionHandler(true, nil)
            case .failure:
                completionHandler(false, Errors.errorTypeFromResponse(response: response.response))
            }
        }
    }
}
