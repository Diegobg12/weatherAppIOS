//
//  weatherManager.swift
//  Clima
//
//  Created by Diego Bustos on 2021-01-19.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation


protocol weatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager ,weather: WeatherModel)
}

struct WeatherManager {
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?units=metric&appid=dfd9fd43f2c54b4f6871314bb4f9e90b"
    
    var delegate: weatherManagerDelegate?
    
    func fetchData(cityName: String) {
        let urlString = "\(weatherUrl)&q=\(cityName)"
        print(urlString)
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String){
        //1 Create URL
        
        if let url = URL(string: urlString){
            //2 create session
            let session = URLSession(configuration: .default)
            //3 give a task to session
            //let task = session.dataTask(with: url, completionHandler: handle(data:response:error:))
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    print(error!)
                    return
                }
                if let safeData = data{
                    if let weather = self.parseJSON(weatherData: safeData) {
                        let weatherVC = WeatherViewController()
                        self.delegate?.didUpdateWeather(self,weather: weather)
                    }
                }
            }
            //4 start the task
            task.resume()
        }
    }
    
    
    func parseJSON(weatherData: Data) -> WeatherModel? {
        
        let decoder = JSONDecoder()
        
        do{
            let decodedData = try decoder.decode(WeatheData.self, from: weatherData)
            
            let weatherID = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: weatherID, cityName: name, temperature: temp)
            
            return weather
            
            
        }catch{
            return nil
        }
    }
    
    
}

