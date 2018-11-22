//
//  MainViewController.swift
//  Parent
//
//  Created by Ahmed Aly on 7/1/17.
//  Copyright © 2017 Ahmed Aly. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps
import GooglePlaces
class MainViewController: BaseViewController,CLLocationManagerDelegate,CityList {
    
    @IBOutlet weak var citiesTableview: UITableView!
    var locationManager = CLLocationManager()
    var cities = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Cities"
        self.addSearchIcon()
        self.getCitiesList()
        self.setLocationConfig()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func cityListReloadData(){
        let citiesList :[String] = CitiesManager.sharedInstance.getCities()
        self.cities = citiesList
        self.citiesTableview.reloadData()
    }
    
    func addSearchIcon(){
        let searchButton: UIBarButtonItem = UIBarButtonItem(image:  (UIImage(named: "Search icon")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal))!, style: UIBarButtonItemStyle.plain, target: self, action: #selector(searchButtonClicked))
        searchButton.imageInsets = UIEdgeInsetsMake(0.0, -10, 0, 0);
        navigationItem.rightBarButtonItem = searchButton;
    }
    
    func getCitiesList(){
        let citiesList :[String] = CitiesManager.sharedInstance.getCities()
        if citiesList.count > 0{
            self.cities = citiesList
            self.citiesTableview.reloadData()
        }else{
            self.addCityToList(city: LONDON,isCurrentCity: false)
        }
    }
    
    func addCityToList(city :String, isCurrentCity: Bool){
        if CitiesManager.sharedInstance.saveCity(cityName: city, isCurrentCity: isCurrentCity){
            self.cities = CitiesManager.sharedInstance.getCities()
        }
        self.citiesTableview.reloadData()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.locationManager = manager
        if self.locationManager.location != nil {
            self.getCityName()
            self.locationManager.stopUpdatingLocation()
        }
    }
    
    func getCityName(){
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: (self.locationManager.location?.coordinate.latitude)!, longitude: (self.locationManager.location?.coordinate.longitude)!)
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            if let city = placeMark.addressDictionary!["State"] as? String {
                self.addCityToList(city: city,isCurrentCity: true)
            }else{
                self.addCityToList(city: LONDON,isCurrentCity: false)
            }
        })
    }
    
    func setLocationConfig(){
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            self.locationManager.startUpdatingLocation()
        }
    }
    
    func numberOfSectionsInTableView(_ tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityTableViewCell", for: indexPath) as! CityTableViewCell
        cell.cityTitleLabel.text = cities[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.openCityForecast(city: cities[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath){
    }
    
    func tableView(_ tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        
        if editingStyle == UITableViewCellEditingStyle.delete
        {
            if CitiesManager.sharedInstance.deleteCity(cityName: cities[indexPath.row]){
                self.cities = CitiesManager.sharedInstance.getCities()
                self.citiesTableview.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String!{
        return "X"
    }
    
    func tableView(_ tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.delete
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func openCityForecast(city :String) {
        let storyBoard :UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let cityForecastViewController :CityForecastViewController = storyBoard.instantiateViewController(withIdentifier: "CityForecastViewController") as! CityForecastViewController
        cityForecastViewController.citName = city
        cityForecastViewController.delegate = self
        self.navigationController?.pushViewController(cityForecastViewController, animated: true)
    }
    
    func searchButtonClicked(){
        let filter = GMSAutocompleteFilter()
        filter.type = .city
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.autocompleteFilter = filter
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
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


