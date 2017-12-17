//
//  UserSettingsViewController.swift
//  WeatherApplication
//
//  Created by Mac on 11/2/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class UserSettingsViewController: UIViewController {
    
    @IBOutlet weak var temperatureUnit: UISegmentedControl!
    @IBOutlet weak var pressureUnit: UISegmentedControl!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //for temperature
        let tempUnit = UserSettings.getUnitOfTemperature()
        switch tempUnit {
        case 0:
            temperatureUnit.selectedSegmentIndex = 0
        case 1:
            temperatureUnit.selectedSegmentIndex = 1
        default:
            break
        }
        
        //for pressure
        let pressUnit = UserSettings.getUnitOfPressure()
        switch pressUnit {
        case 0:
            pressureUnit.selectedSegmentIndex = 0
        case 1:
            pressureUnit.selectedSegmentIndex = 1
        default:
            break
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func temperatureClick(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            UserSettings.setUnitOfTemperature(unitType: 0)
            alertCall("Temperature unit changed", "To °C")
            print("Temperature in degree Celsius")
        case 1:
            UserSettings.setUnitOfTemperature(unitType: 1)
            alertCall("Temperature unit changed", "To °F")
            print("Temperature in degree Fahreinheit")
        default:
            break
        }
    }
    
    @IBAction func pressureClick(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            UserSettings.setUnitOfPressure(unitType: 0)
            alertCall("Pressure unit changed", "To hPa")
            print("Pressure in hPa")
        case 1:
            UserSettings.setUnitOfPressure(unitType: 1)
            alertCall("Pressure unit changed", "To bar")
            print("Pressure in bar")
        default:
            break
        }
    }
    
    func alertCall(_ alertTitle: String, _ alertMessage: String) {
        let alertControl = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertControl.addAction(okAction)
        present(alertControl, animated: true, completion: nil)
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
