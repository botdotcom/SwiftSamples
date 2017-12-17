//
//  CitySearchController.swift
//  WeatherApplication
//
//  Created by Mac on 11/2/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

var favCities: [(String, String, String)] = []

class CitySearchController: UITableViewController {
    
    //public var resultSearchController: UISearchController? = nil
    let resultSearchController = UISearchController(searchResultsController: nil)
    
    var request = CitySearch()
    
    public var cityKey: String?
    public var areaKey: String?
    
    var keysArray: [String] = [] //location keys
    var citiesArray: [String] = []  //search result title
    var areasArray: [String] = []  //details of search i.e. state and country
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        //setting the search controller
        resultSearchController.searchResultsUpdater = self
        
        //setting the search bar in view controller
        let searchBar = resultSearchController.searchBar
        searchBar.sizeToFit()
        //searchBar.placeholder = "Weather for a City"
        navigationItem.title = "Search City"
        tableView.tableHeaderView = resultSearchController.searchBar
        
        //setting appearance of search results
        resultSearchController.obscuresBackgroundDuringPresentation = false
        resultSearchController.hidesNavigationBarDuringPresentation = false
        resultSearchController.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true  //very important step
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return citiesArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath)
        if citiesArray.count > 0 {
            cell.textLabel?.text = citiesArray[indexPath.row]
            cell.detailTextLabel?.text = areasArray[indexPath.row]
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //test
        print("City chosen: ---------")
        print(keysArray[indexPath.row], citiesArray[indexPath.row], areasArray[indexPath.row])
        //actual
        //favCities.append((keysArray[indexPath.row], citiesArray[indexPath.row], areasArray[indexPath.row]))
        cityKey = citiesArray[indexPath.row] //keysArray[indexPath.row]
        areaKey = areasArray[indexPath.row]
        performSegue(withIdentifier: "showCitySegue", sender: self)  //favCitiesSegue
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        //let destination: FavCitiesViewController = segue.destination as! FavCitiesViewController
        let destination: ViewController = segue.destination as! ViewController
        destination.selectedCity = cityKey!
        destination.selectedCityArea = areaKey!
    }
    
}


extension CitySearchController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchBarText = searchController.searchBar.text
            else { return }
        var locations: [(String, String, String)] = []
        if searchBarText.characters.count >= 3 {
            //locations = request.getSearchResults(searchString: searchBarText)
            if citiesArray.count > 0 && areasArray.count > 0 {
                citiesArray.removeAll()
                areasArray.removeAll()
            }
            locations = request.getSearchResults(searchString: searchBarText)
            for item in locations {
                keysArray.append(item.0)
                citiesArray.append(item.1)
                areasArray.append(item.2)
            }
            tableView.reloadData()
        }
    }
}
