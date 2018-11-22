//
//  CityForecastViewController.swift
//  Parent
//
//  Created by Ahmed Aly on 7/2/17.
//  Copyright © 2017 Ahmed Aly. All rights reserved.
//

import UIKit
import ObjectMapper
class CityForecastViewController: BaseViewController {

    @IBOutlet weak var addCityButton: UIButton!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var cityTableview: UITableView!
  
    var citName :String?
    var cityForecast = [ForecastDay]()
    weak var delegate: CityList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setPageComponents()
        self.getCityForecast()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setPageComponents(){
        self.cityLabel.text = self.citName
        if CitiesManager.sharedInstance.isCityIsSaved(cityName: self.citName!){
            self.addCityButton.setImage(UIImage(named: "checked_btn"), for: .normal)
        }else{
            if CitiesManager.sharedInstance.getCities().count == 5 {
                self.addCityButton.isEnabled = false
            }
            self.addCityButton.setImage(UIImage(named: "add_btn"), for: .normal)
        }
    }
    
    func getCityForecast(){
        self.showLoader()
        ServerManager().webConnectionWithMethodName(methodName:"q=\((citName)!)&days=5", mType: HTTPServerMethod.post, params:nil , completionHandler: { (data:[String : Any]?) in
            self.hideLoader()
            let forecast = (data?["forecast"] as! [String :Any])["forecastday"]
            print(forecast!)
            self.cityForecast = Mapper<ForecastDay>().mapArray(JSONArray: forecast as! [[String :Any]])
            self.cityTableview.reloadData()
        }, faildHandler: { (status:StatusServer?) in
            self.hideLoader()
            self.navigationController?.popViewController(animated: true)
            self.showAlertWithText(txt: "Sorry we can't get this city")
            
        })
    }
    
    func numberOfSectionsInTableView(_ tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cityForecast.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityForecastTableViewCell", for: indexPath) as! CityForecastTableViewCell
        cell.dateLabel.text = "Date: \((self.cityForecast[indexPath.row].date)!)"
        cell.maxTempLabel.text = "Max Temp: \((self.cityForecast[indexPath.row].forecast?.maxtemp_c)!)"
        cell.minTempLabel.text = "Min Temp: \((self.cityForecast[indexPath.row].forecast?.mintemp_c)!)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    @IBAction func addButtonCLicked(_ sender: Any) {
        if CitiesManager.sharedInstance.isCityIsSaved(cityName: self.citName!){
            let _ = CitiesManager.sharedInstance.deleteCity(cityName: self.citName!)
            self.addCityButton.setImage(UIImage(named: "add_btn"), for: .normal)
            if CitiesManager.sharedInstance.getCities().count == 5 {
                self.addCityButton.isEnabled = false
            }
        }else{
            let _ = CitiesManager.sharedInstance.saveCity(cityName: self.citName!, isCurrentCity: false)
            self.addCityButton.setImage(UIImage(named: "checked_btn"), for: .normal)
            self.addCityButton.isEnabled = true
        }
        self.delegate?.cityListReloadData()
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

protocol CityList : class {
    func cityListReloadData()
}
