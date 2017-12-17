//
//  CitySearch.swift
//  WeatherApplication
//
//  Created by Mac on 11/2/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import Foundation

public var cityData = Array<Dictionary<String,Any>>()

//public var cityData: [[String:Any]] = [[:]]

class CitySearch {
    private let cityBaseURL = "http://dataservice.accuweather.com/locations/v1/cities/autocomplete?q="
    private let weatherAPIKey = "AoIwXiwGAjJ8AJ7wVi09Xw1XSqwMDBJg" /* GIsKNAwNInDPKLpzqUi5BgmM5eEtdgjC */
    /*"2Ls8uKCVGi884TtNU1qvtTopmAgNXI9N"*/ /*"QXwbG2PbNGFlNaMlh2yDsuuGtL3aV5We"*/  /*"zCxylLYl90od2lBKwgI4YXLlz39xKmo6"*/
    
    func getCityResultsFromAPI(searchString: String) {
        let cityFullURL = cityBaseURL + searchString.replacingOccurrences(of: " ", with: "%20") + "&apikey=" + weatherAPIKey
        
        if let citiesRequestURL = URL(string: cityFullURL) {
            //asynchronous call to API
            let task = URLSession.shared.dataTask(with: citiesRequestURL) {
                (data, response, error) in
                
                if error != nil {
                    print("Error found: \(error as Any)")
                }
                    
                else {
                    if let content = data {
                        do {
                            let citiesdata = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as! [[String:Any]]
                            DispatchQueue.main.sync {
                                for item in citiesdata {
                                    //print(item)
                                    if cityData.count > 1 {
                                        cityData.removeFirst()
                                        //cityData.append(item)
                                    }
                                    cityData.append(item)
                                }
                            }
                        }
                        catch {
                            //error found
                            print("Cannot get JSON data")
                        }
                    }
                }
            }
            task.resume()
        }
        else {
            print("Couldn't print any city data!")
        }
    }
    
    
    func getSearchResults(searchString: String) -> [(String, String, String)] { //[String] { //([String], [String]) {
        if searchString != "" {
            //let searchResult = getCityResultsFromAPI(searchString: searchString)
            getCityResultsFromAPI(searchString: searchString)
            var locations: [(String, String, String)] = []
            //var areas: [String] = []
            var area: String = ""
            //put cities, their state and country in separate arrays and return
            for item in cityData {
                //cities.append(item["LocalizedName"] as! String)
                let locationKey = item["Key"] as! String
                let cityName = item["LocalizedName"] as! String
                if let nestedCountry = item["Country"] as? [String:AnyObject], let country = nestedCountry["LocalizedName"] as? String {
                    area = country
                }
                if let nestedArea = item["AdministrativeArea"] as? [String:AnyObject], let finalArea = nestedArea["LocalizedName"] as? String {
                    area = finalArea + ", " + area
                }
                print(locationKey, cityName, area)
                locations.append((locationKey, cityName, area))
            }
            return locations
        }
        else {
            return [] // ([],[])
        }
    }
}
