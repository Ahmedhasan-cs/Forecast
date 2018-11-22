//
//  Day.swift
//  Parent
//
//  Created by Ahmed Aly on 7/2/17.
//  Copyright © 2017 Ahmed Aly. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

final class ForecastDay: Mappable{
    
    var date:String?
    var forecast :Forecast?
    
    public required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        date <- map["date"]
        forecast <- map["day"]
    }
    
}


