//
//  Forecast.swift
//  Parent
//
//  Created by Ahmed Aly on 7/2/17.
//  Copyright © 2017 Ahmed Aly. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

final class Forecast: Mappable{
    var avghumidity:String?
    var avgtemp_c:String?
    var avgtemp_f:String?
    var avgvis_km:String?
    var avgvis_miles:String?
    var maxtemp_c:String?
    var maxtemp_f:String?
    var maxwind_kph:String?
    var maxwind_mph:String?
    var mintemp_c:String?
    var mintemp_f:String?
    var totalprecip_in:String?
    var totalprecip_mm:String?
    
    init() {
        
    }
    
    public required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        avghumidity <- (map["avghumidity"], StringTransform())
        avgtemp_c <- (map["avgtemp_c"], StringTransform())
        avgtemp_f <- (map["avgtemp_f"], StringTransform())
        avgvis_km <- (map["avgvis_km"], StringTransform())
        avgvis_miles <- (map["avgvis_miles"], StringTransform())
        maxtemp_c <- (map["maxtemp_c"], StringTransform())
        maxtemp_f <- (map["maxtemp_f"], StringTransform())
        maxwind_kph <- (map["maxwind_kph"], StringTransform())
        maxwind_mph <- (map["maxwind_mph"], StringTransform())
        mintemp_c <- (map["mintemp_c"], StringTransform())
        mintemp_f <- (map["mintemp_f"], StringTransform())
        totalprecip_in <- (map["totalprecip_in"], StringTransform())
        totalprecip_mm <- (map["totalprecip_mm"], StringTransform())
    }
    
}


