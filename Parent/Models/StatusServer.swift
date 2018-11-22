import Foundation
import ObjectMapper
import Alamofire
struct StringTransform: TransformType {
    
    func transformFromJSON(_ value: Any?) -> String? {
        return value.flatMap(String.init(describing:))
    }
    
    func transformToJSON(_ value: String?) -> Any? {
        return value
    }
    
}
class StatusServer:Mappable{
    
    var message : String?
   	var debug : String?
    var statusCode : Int?
    var response : Any?

    public required init?(map: Map) {
        
    }
    
    func mapping(map: Map)
    {
        debug <- map["debug"]
        statusCode <- map["status_code"]
        message <- map["message"]
        response <- map["results"]
        if(message == nil){
            message = ""
        }
        
        if(statusCode == nil){
            return
        }
    }
 

    
}
