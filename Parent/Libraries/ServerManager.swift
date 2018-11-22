import UIKit
import Alamofire
import Reachability
import ObjectMapper

public enum HTTPServerMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

extension Dictionary {
    
    mutating func merge(with dictionary: Dictionary) {
        dictionary.forEach { updateValue($1, forKey: $0) }
    }
    
    func merged(with dictionary: Dictionary) -> Dictionary {
        var dict = self
        dict.merge(with: dictionary)
        return dict
    }
}

class ServerManager: NSObject {
    
    func webConnectionWithMethodName(methodName:String , mType:HTTPServerMethod , params:Parameters? , completionHandler: @escaping ([String:Any]?) -> Void , faildHandler: @escaping (StatusServer?) -> Void ){
        if(!ServerManager.checkNetConnection()){
            
            let status:StatusServer = StatusServer(JSONString: "{}")!
            status.message = NS_INTERNET
            DispatchQueue.main.async {
                
                faildHandler(status)
            }
            
            return
        }
        var allParams : [String : Any]?
        if params != nil {
            allParams = params!
        }
       
       // print(allParams!)
        var address = "\(BASE_URL)\(methodName)"
        if let encoded = address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        {
            print(encoded)
            address = encoded
        }
        
        Alamofire.request(address, method:HTTPMethod(rawValue: mType.rawValue)!, parameters: allParams , encoding: URLEncoding.default ,headers:nil)
            .responseJSON { response in
                debugPrint(response)
                if (response.result.error != nil){
                    let status:StatusServer = StatusServer(JSONString: "{}")!
                    status.message = response.result.error?.localizedDescription
                    DispatchQueue.main.async {
                        
                        faildHandler(status)
                    }
                    return
                }
                
                if (response.data?.count == 0){
                    let status:StatusServer = StatusServer(JSONString: "{}")!
                    // status.message = ApplicationConstant.AMLocalizedString("NO_DATA_RECIEVED")
                    DispatchQueue.main.async {
                        
                        faildHandler(status)
                    }
                    return
                    
                }
                
                if (response.result.value != nil) {
                    let item = Mapper<StatusServer>().map(JSON: response.result.value as! [String : Any])
                    if(response.response?.statusCode == 200){
                        DispatchQueue.main.async {
                            if let response = response.result.value as? [String : Any] {
                                completionHandler(response)
                            }
                        }
                    }
                    else{
                        DispatchQueue.main.async {
                            
                            faildHandler(item)
                        }
                    }
                }
        }
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func webConnectionWithMethodName(methodName:String , mType:HTTPServerMethod , params:Parameters? , completionHandler: @escaping (String) -> Void , faildHandler: @escaping (StatusServer?) -> Void ){
        if(!ServerManager.checkNetConnection()){
            
            let status:StatusServer = StatusServer(JSONString: "{}")!
            status.message = NS_INTERNET
            DispatchQueue.main.async {
                
                faildHandler(status)
            }
            
            return
        }
        Alamofire.request("\(BASE_URL)\(methodName)", method:HTTPMethod(rawValue: mType.rawValue)!, parameters: params , encoding: URLEncoding.default ,headers:nil)
            .responseJSON { response in
                debugPrint(response)
                if (response.result.error != nil){
                    let status:StatusServer = StatusServer(JSONString: "{}")!
                    status.message = response.result.error?.localizedDescription
                    DispatchQueue.main.async {
                        
                        faildHandler(status)
                    }
                    return
                }
                
                if (response.data?.count == 0){
                    let status:StatusServer = StatusServer(JSONString: "{}")!
                    // status.message = ApplicationConstant.AMLocalizedString("NO_DATA_RECIEVED")
                    DispatchQueue.main.async {
                        
                        faildHandler(status)
                    }
                    return
                    
                }
                
                if (response.result.value != nil) {
                    let item = Mapper<StatusServer>().map(JSON: response.result.value as! [String : Any])
                    if(response.response?.statusCode == 200){
                        DispatchQueue.main.async {
                            if let result :String = (response.result.value! as AnyObject) as? String{
                                completionHandler(result)
                            }else if let result :NSDictionary = (response.result.value! as AnyObject) as? NSDictionary{
                                completionHandler(result.value(forKey: "results") as! String)
                            }
                        }
                    }
                    else{
                        DispatchQueue.main.async {
                            
                            faildHandler(item)
                        }
                    }
                }
        }
    }
    
    
    static  func checkNetConnection() -> Bool{
        let reachability: Reachability
        reachability =  Reachability()!
        return reachability.isReachable
        
    }
    
}
