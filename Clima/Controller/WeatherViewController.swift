//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate, weatherManagerDelegate {
    

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        weatherManager.delegate = self
        searchTextField.delegate = self
    }


    @IBAction func searchPressed(_ sender: UIButton) {
        
        print(searchTextField.text!)
        searchTextField.endEditing(true)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(searchTextField.text!)
        searchTextField.endEditing(true)
        return true
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //Use searchTextField to get the wheather
        
        if let city = searchTextField.text {
            weatherManager.fetchData(cityName: city)
            
        }
        searchTextField.text = ""
    }
    
    
    func didUpdateWeather(_ weatherManager: WeatherManager ,weather: WeatherModel) {
        
        print(weather.temperature)
    }
}

