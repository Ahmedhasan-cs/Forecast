//
//  FavoriteManager.swift
//  Mostalhat
//
//  Created by Ahmed Aly on 3/2/17.
//  Copyright © 2017 Ahmed Aly. All rights reserved.
//

import UIKit

class CitiesManager: NSObject {
    static let sharedInstance = CitiesManager()
    
    func saveCity(cityName :String,isCurrentCity: Bool) -> Bool{
        if var citiesList :[String] = CachingManager.getArrayWithName(CITIES, inRelativePath: "", inDocument: true) as? [String]{
            if self.isCityIsSaved(cityName: cityName) == false {
                if isCurrentCity {
                    citiesList[0] = cityName
                }else{
                    citiesList.append(cityName)
                }
                CachingManager.saveArray(toPlist: citiesList, withName: CITIES, inRelativePath: "", inDocument: true)
                return true
            }
        }else{
            CachingManager.saveArray(toPlist: [cityName], withName: CITIES, inRelativePath: "", inDocument: true)
            return true
        }
        return false
    }
    
    func deleteCity(cityName :String) -> Bool{
        if var citiesList :[String] = CachingManager.getArrayWithName(CITIES, inRelativePath: "", inDocument: true) as? [String]{
            for  i in 0..<citiesList.count {
                if cityName == citiesList[i]{
                    citiesList.remove(at: i)
                    CachingManager.saveArray(toPlist: citiesList, withName: CITIES, inRelativePath: "", inDocument: true)
                    return true
                }
            }
        }
        return false
    }
    
    func isCityIsSaved(cityName :String) -> Bool{
        if let citiesList :[String] = CachingManager.getArrayWithName(CITIES, inRelativePath: "", inDocument: true) as? [String]{
            for  i in 0..<citiesList.count {
                if cityName == citiesList[i]{
                    return true
                }
            }
        }
        
        return false
    }
    
    func getCities() ->([String]){
        if let citiesList :[String] = CachingManager.getArrayWithName(CITIES, inRelativePath: "", inDocument: true) as? [String]{
            return citiesList
        }
        
        return []
    }
    
}

