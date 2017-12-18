//
//  ViewController.swift
//  WeatherApplication
//
//  Created by Mac on 02/11/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDataSource,UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var areaName: UILabel!
    @IBOutlet weak var mainTempL: UILabel!
    
    @IBOutlet weak var weatherDescL: UILabel!
    
    @IBOutlet weak var mainWeatherIcon: UIImageView!
    
    @IBOutlet weak var humidityL: UILabel!
    @IBOutlet weak var pressureL: UILabel!
    //@IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var sunriseL: UILabel!
    @IBOutlet weak var sunsetL: UILabel!
    
   
    @IBOutlet weak var hourlyCollectionView: UICollectionView!
    
   
    @IBOutlet weak var weeklyTableView: UITableView!
    
    public var selectedCity: String = ""
    public var selectedCityArea: String = ""
    
    
    // Variables and Arrays declaration
    var todayTime:[String] = [String]()
    var futureDate:[String] = [String]()
    var todayTemp = [Int]()
    var futureTemp = [Int]()
    var futureDay = [String]()
    var noOfDetails:Int = 0
    var noOfSections:Int = 0
    var timeItems: Int = 0
    var todayImages = [String]()
    var futureImages = [String]()
    
    
    // Onclick Function
    /*@IBAction func submit(_ sender: Any) {
        
        self.emptyArray()
        
        self.fetchCurrentData()
         self.fetchData()
      
        
    }*/
        
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.viewDidAppear(true)
        // Do any additional setup after loading the view, typically from a nib.
        
        if selectedCity != nil {
            self.emptyArray()
            self.fetchCurrentData()
            self.fetchData()
        }
        navigationItem.title = "WeatherMate"
        hourlyCollectionView.dataSource = self
        weeklyTableView.dataSource = self
        weeklyTableView.delegate = self

    }
    
    //reloading data, especially after unit change
    override func viewDidAppear(_ animated: Bool) {
        if selectedCity != nil {
            self.emptyArray()
            self.fetchCurrentData()
            self.fetchData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // Functions For TableView And collection View
    
    func numberOfSections(in collectionView: UICollectionView) -> Int{
        
        return noOfDetails
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return noOfSections
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! myCollectionView
        
        
        let imageId = self.todayImages[indexPath.section]
        
     /*   fetching Image from Url
         let iconUrl = URL(string: "http://openweathermap.org/img/w/"+imageId+".png")!
        
        let imagedata = try? Data(contentsOf: iconUrl)
        cell.icon.image = UIImage(data: imagedata!) */
        
         cell.icon.image = UIImage(named: imageId)
        
        cell.timeLabel.text = self.todayTime[indexPath.section]
        
        if UserSettings.getUnitOfTemperature() == 0 {
            cell.tempLabel.text = String(self.todayTemp[indexPath.section])+" °C"
        }
        else {
            cell.tempLabel.text = String(self.todayTemp[indexPath.section])+" °F"
        }
        
        return cell
        
        
        
    }
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noOfSections
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell" , for: indexPath) as? WeeklyTableView
        
        
        let imageId = self.futureImages[indexPath.section]
        
      /*  let iconUrl = URL(string: "http://openweathermap.org/img/w/"+imageId+".png")!
        
        
        
        let imagedata = try? Data(contentsOf: iconUrl) */
        
        cell?.icon.image = UIImage(named: imageId)
        cell?.weekDay.text = futureDay[indexPath.section]
        if UserSettings.getUnitOfTemperature() == 0 {
            cell?.weekTemp.text = String(futureTemp[indexPath.section])+" °C"
        }
        else {
            cell?.weekTemp.text = String(futureTemp[indexPath.section])+" °F"
        }
        
        return cell!
    }
    
    

    
    
    
    
    // Function to Fetch Current DATA
    
    
    
    
    func fetchData() {
        
        // let url = URL(string :"http ://api.openweathermap.org/data/2.5/weather?q=London,uk&appid=###") //enter your own API key
        
        //let url = URL(string :"http://api.openweathermap.org/data/2.5/forecast?q=" + cityTextField.text!.replacingOccurrences(of: " ", with: "%20") + ",uk&appid=###") //enter your own API key
        
        let url = URL(string :"http://api.openweathermap.org/data/2.5/forecast?q=" + selectedCity.replacingOccurrences(of: " ", with: "%20") + ",uk&appid=08e64df2d3f3bc0822de1f0fc22fcb2d")
        
        
        let task = URLSession.shared.dataTask(with: url!){(data,response,error) in
            
            if error != nil{
                print(error!)
                
            }else {
                
                if let urlContent  = data {
                    
                    do{
                        let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        
                        print(jsonResult)
                        
                        
                        // City
                        /*   if let city = jsonResult["city"] as? NSDictionary? {
                         
                         print(city)
                         
                         }
                         
                         //Cnt
                         if let cnt = jsonResult["cnt"] as? Int {
                         print(cnt)
                         }
                         
                         
                         */
                        
                        // List
                        var k = 0
                        if let list = jsonResult["list"] as? NSArray  {
                            
                            self.noOfSections = 1
                            self.noOfDetails = 0
                            
                            for i in 0..<list.count {
                                
                                
                                
                                let detail = list[i] as? NSDictionary
                                
                                
                                let  timeStamp = detail?["dt_txt"] as? String
                                
                                
                                let main = detail?["main"] as? NSDictionary
                                var  temp = main?["temp"] as? Int
                                if UserSettings.getUnitOfTemperature() == 0 {
                                    temp =  temp! - 273
                                }
                                if UserSettings.getUnitOfTemperature() == 1 {
                                    temp =  temp! - 273
                                    temp = (9 * temp!)/5 + 32
                                }
                                
                                // Weather Icons
                                
                                
                                let weather = detail?["weather"] as? NSArray
                                
                                let weatherDetail = weather?[0] as? NSDictionary
                                
                                let icon = weatherDetail?["icon"]
                                
                                
                                
                                
                                
                                // Separate Parts of Date
                                let components = timeStamp?.components(separatedBy: " ")
                                let dateComponent = components?[0]
                                let timeComponent = components?[1]
                                
                                
                                
                                
                                
                                // Current System Date
                                let date = Date()
                                let formatter = DateFormatter()
                                formatter.dateFormat = "yyyy.MM.dd"
                                
                                // conveting json string date to date
                                
                                let todayDate = formatter.date(from: dateComponent! )
                                
                                if ( todayDate! < date) {
                                    
                                    self.todayTime.append(timeComponent!)
                                    self.todayTemp.append(temp!)
                                    self.todayImages.append(icon as! String)
                                    
                                    if i == 0 {
                                        
                                        self.futureDay.append("Today")
                                        self.futureTemp.append(temp!)
                                        self.futureImages.append(icon as! String)
                                    }
                                    
                                    self.noOfDetails += 1
                                    print("TIME",timeComponent!)
                                    print("TEMP",temp!)
                                    
                                }
                                
                                if ( todayDate! > date ) {
                                    
                                    k += 1
                                    if k % 8 == 1 {
                                        print("********************************DAY\(k/8 + 1)***************")
                                        
                                        
                                    }
                                    // If Time is 12 Am then store it as next day
                                    if (timeComponent == "00:00:00"){
                                        self.futureDate.append(dateComponent!)
                                        self.futureTemp.append(temp!)
                                        self.futureImages.append(icon as! String)
                                        if let day = self.getDayOfWeek(dateComponent!){
                                            
                                            self.futureDay.append(day)
                                        }
                                        
                                        print("DATE",dateComponent!)
                                        print("TIME",timeComponent!)
                                        print("TEMP",temp!)
                                        
                                    }
                                }
                                
                                
                                
                            }
                            
                            print(self.futureImages)
                            
                        }
                        
                        
                        DispatchQueue.main.sync(execute: {
                            
                            
                            
                            self.hourlyCollectionView.dataSource = self
                            
                            self.hourlyCollectionView.reloadData()
                            
                            self.weeklyTableView.reloadData()
                            
                            
                            
                            print(self.noOfSections)
                            print(self.noOfDetails)
                        })
                        
                    }catch {
                        
                        print("json processing failed")
                    }
                    
                    
                    
                }
                
                
            }
            
            
            
        }
        
        
        task.resume()
        
    }
 
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // Function to fetch todays Data
    
    
    func fetchCurrentData() {
        
        
        
        //if let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=" + cityTextField.text!.replacingOccurrences(of: " ", with: "%20") + ",uk&appid=08e64df2d3f3bc0822de1f0fc22fcb2d") {
        
        if let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=" + selectedCity.replacingOccurrences(of: " ", with: "%20") + ",uk&appid=08e64df2d3f3bc0822de1f0fc22fcb2d") {
            
        
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in // URLSession.shared().dataTask(with: url) { (data, response, error) is now URLSession.shared.dataTask(with: url) { (data, response, error)
                
                if error != nil {
                    
                    print(error as Any)
                    
                } else {
                    
                    if let urlContent = data {
                        
                        do {
                            
                            let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject // Added "as anyObject" to fix syntax error in Xcode 8 Beta 6
                            
                            print(jsonResult)
                            
                            print(jsonResult["name"] as Any)
                            
                            /*      if let main = jsonResult["main"] as? NSDictionary? {
                             if let humidity = main?["humidity"] as? Double {
                             
                             print(humidity)
                             
                             }
                             } */
                            
                            
                            if let description = ((jsonResult["weather"] as? NSArray)?[0] as? NSDictionary)?["description"] as? String {
                                if let main = jsonResult["main"] as? NSDictionary? {
                                     if let sys = jsonResult["sys"] as? NSDictionary {
                                        if var temp = main?["temp"] as? Int {
                                            if UserSettings.getUnitOfTemperature() == 0 {
                                        temp -= 273
                                            }
                                            if UserSettings.getUnitOfTemperature() == 1 {
                                                temp -= 273
                                                temp = (9 * temp)/5 + 32
                                            }
                                        print(temp)
                                        if let humidity = main?["humidity"] as? Double {
                                            if var pressure = main?["pressure"] as? Double {
                                                if let sunrise = sys["sunrise"] as? Double {
                                                    if let sunset = sys["sunset"] as? Double {
                                                if let weathericonDescription = ((jsonResult["weather"] as? NSArray)?[0] as? NSDictionary)?["icon"] as? String {
                                                    print(weathericonDescription)
                                                    let imageurl = URL(string: "http://openweathermap.org/img/w/"+weathericonDescription+".png")!
                                                    print(imageurl)
                                                    // let imagerequest = NSMutableURLRequest(url: imageurl)
                                                    /*        let imagetask = URLSession.shared.dataTask(with: imagerequest as URLRequest) {
                                                     data, response, error in
                                                     
                                                     if error != nil {
                                                     
                                                     print(error)
                                                     
                                                     } else { */
                                                    
                                                    
                                                    /* URL for Image
                                                    let imagedata = try? Data(contentsOf: imageurl) //make sure your image in this url does exist, otherwise unwrap in a if let */
 
 
                                                        //Time conversion method for sunset
                                                    func convertUnixTime (_ unixTime:Double) -> String {
                                                        var finalTime: String = ""
                                                        if  let timeResult = (unixTime as? Double) {
                                                            let date = NSDate(timeIntervalSince1970: TimeInterval(timeResult))
                                                            let dateFormatter = DateFormatter()
                                                            dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
                                                            dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
                                                            dateFormatter.timeZone = TimeZone.current
                                                            let localDate = dateFormatter.string(from: date as Date)
                                                            print(localDate)
                                                            let calendar = Calendar.current
                                                            
                                                            let hour = calendar.component(.hour, from: date as Date)
                                                            let minutes = calendar.component(.minute, from: date as Date)
                                                            let seconds = calendar.component(.second, from: date as Date)
                                                            print("hours = \(hour):\(minutes):\(seconds)")
                                                            finalTime = String(hour) + ":" + String(minutes) + ":" + String(seconds)
                                                            
                                                        }
                                                        return finalTime
                                                    }
                                                    
                                                    DispatchQueue.main.sync(execute: {
                                                        /*   if let data = data {
                                                         if let iconImage = UIImage(data:data) {
                                                         
                                                         self.weatherIconImage.image = iconImage
                                                         }
                                                         } */
                                                        
                                                        self.cityName.text = self.selectedCity
                                                        self.areaName.text = self.selectedCityArea
                                                        
                                                        self.mainWeatherIcon.image = UIImage(named: weathericonDescription)
                                                        self.weatherDescL.text = description.capitalized
                                                        if UserSettings.getUnitOfTemperature() == 0 {
                                                            self.mainTempL.text = String(temp) + " °C"
                                                        }
                                                        else {
                                                            self.mainTempL.text = String(temp) + " °F"
                                                        }
                                                        self.humidityL.text = "Humidity: " + String(humidity) + "%"
                                                        if UserSettings.getUnitOfPressure() == 0 {
                                                            self.pressureL.text = "Pressure: " + String(pressure) + " hPa"
                                                        }
                                                        else {
                                                            pressure /= 1000
                                                            self.pressureL.text = "Pressure: " + String(pressure) + " bar"
                                                        }
                                                        self.sunsetL.text = "Sunrise: " + convertUnixTime(sunrise)
                                                        self.sunriseL.text = "Sunset: " + convertUnixTime(sunset)
                                                        
                                                       
                                                    })
                                                }
                                            }
                                        }
                                        /*    if let temp = ((jsonResult["main"] as? NSArray)?[4] as? NSDictionary)?["temp"] as? String {
                                         
                                         DispatchQueue.main.sync(execute: {
                                         
                                         self.tempLabel.text = "Temperature:" + temp
                                         
                                         })
                                         
                                         
                                         } */
                                            }
                                        }
                                        }
                                    }
                                }
                            }
                        } catch {
                            
                            print("JSON Processing Failed")
                            
                        }
                        
                    }
                    
                    
                }
                
                
            }
            
            task.resume()
            
        } else {
            
            weatherDescL.text = "Couldn't find weather for that city - please try another."
            
        }

        
        
        
    }
    
    
    
    
    
    func getDayOfWeek(_ today:String) -> String? {
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let todayDate = formatter.date(from: today) else { return nil }
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: todayDate)
        var day:String
        
        switch weekDay {
        case 1:
            day = "Sunday"
        case 2:
            day = "Monday"
        case 3:
            day = "Tuesday"
        case 4:
            day = "Wednesday"
        case 5:
            day = "Thursday"
        case 6:
            day = "Friday"
        case 7:
            day = "Saturday"
        default:
            day = ""
            
        }
        
        
        if day != ""{
            
            return day
            
            
        }else {
            
            
            return nil
        }
        
        
        
        
        
    }

    
    
    func emptyArray() {
        
        
        todayTime.removeAll()
        todayImages.removeAll()
        futureDate.removeAll()
        todayTemp.removeAll()
        
        futureDay.removeAll()
        futureTemp.removeAll()
        
        futureImages.removeAll()
        

        
        
    }
    
    
    
    


}

