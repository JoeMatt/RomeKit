import Foundation
import Dispatch
import Alamofire
import ObjectMapper

public class Assets {
    
    public static func all(
        queue: DispatchQueue? = nil,
        completionHandler: @escaping ([Asset]?, Errors?) -> ()) {
        
        let url = RomeRoutes.url(route: .Assets, params: [])
        
        NetworkManager.shared.request(url).validate().responseString(queue: queue) { response in
            
            switch response.result {
            case .success(let assetsJSON):
                if let assets = Mapper<Asset>().mapArray(JSONObject: assetsJSON) {
                    completionHandler(assets, nil)
                } else {
                    completionHandler(nil, Errors.ErrorMappingAssets)
                }
            case .failure:
                completionHandler(nil, Errors.errorTypeFromResponse(response: response.response))
            }
            
        }
        
    }
    
    public static func getLatestAssetByRevision(
        name: String,
        revision: String,
        queue: DispatchQueue? = nil,
        completionHandler: @escaping (Asset?, Errors?) -> ()) {
        
        let url = RomeRoutes.url(route: .Assets, params: [name, revision])
        
        NetworkManager.shared.request(url).validate().responseString(queue: queue) { response in
            
            switch response.result {
            case .success(let assetJSON):
                if let asset = Mapper<Asset>().map(JSONObject: assetJSON) {
                    completionHandler(asset, nil)
                } else {
                    completionHandler(nil, Errors.ErrorMappingAsset)
                }
            case .failure:
                completionHandler(nil, Errors.errorTypeFromResponse(response: response.response))
            }
            
        }
        
    }
    
    public static func getAssetById(
        id: String,
        queue: DispatchQueue? = nil,
        completionHandler: @escaping (Asset?, Errors?) -> ()) {
        
        let url = RomeRoutes.url(route: .Assets, params: [id])
        
        NetworkManager.shared.request(url).validate().responseString(queue: queue) { response in
            
            switch response.result {
            case .success(let assetJSON):
                if let asset = Mapper<Asset>().map(JSONObject: assetJSON) {
                    completionHandler(asset, nil)
                } else {
                    completionHandler(nil, Errors.ErrorMappingAsset)
                }
            case .failure:
                completionHandler(nil, Errors.errorTypeFromResponse(response: response.response))
            }
            
        }
        
    }
    
    public static func create(
        name: String,
        revision: String,
        data: Data,
        queue: DispatchQueue? = nil,
        progress: @escaping (Progress) -> (),
        completionHandler: @escaping (Asset?, Errors?) -> ()) {
        
        let url = RomeRoutes.url(route: .Assets, params: [])
        let headers : HTTPHeaders = [Headers.ASSET_NAME: name, Headers.ASSET_REVISION: revision, Headers.ASSET_CONTENT_TYPE: Headers.DEFAULT_ASSET_CONTENT_TYPE]

        NetworkManager.shared.upload(data, to: url, method: HTTPMethod.post, headers: headers).uploadProgress(closure: {
            progress($0)
            return
        })
            .validate().responseJSON(queue: queue) { response in
                switch response.result {
                case .success(let assetJSON):
                    if let asset = Mapper<Asset>().map(JSONObject: assetJSON) {
                        completionHandler(asset, nil)
                    } else {
                        completionHandler(nil, Errors.ErrorMappingAsset)
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
        
        let url = RomeRoutes.url(route: .Assets, params: [id])
        
        NetworkManager.shared.request(url, method: HTTPMethod.delete, encoding: URLEncoding.default, headers: nil).validate().responseString(queue: queue) { response in
            
            switch response.result {
            case .success:
                completionHandler(true, nil)
            case .failure:
                completionHandler(false, Errors.errorTypeFromResponse(response: response.response))
            }
            
        }
        
    }
    
    public static func updateStatus(
        id: String,
        active: Bool,
        queue: DispatchQueue? = nil,
        completionHandler: @escaping (Bool?, Errors?) -> ()) {
        
        let url = RomeRoutes.url(route: .Assets, params: [id])
        let params = ["active": active]
        
        NetworkManager.shared.request(url, method: .patch, parameters: params, encoding: JSONEncoding.default, headers: nil).validate().responseString(queue: queue) { response in
            
            switch response.result {
            case .success:
                completionHandler(true, nil)
            case .failure:
                completionHandler(false, Errors.errorTypeFromResponse(response: response.response))
            }
            
        }
        
    }
    
}
