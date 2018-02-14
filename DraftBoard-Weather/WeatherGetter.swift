//
//  WeatherGetter.swift
//  DraftBoard-Weather
//
//  Created by Konrad Wright on 2/13/18.
//  Copyright © 2018 Konrad Wright. All rights reserved.
//

import Foundation

class WeatherGetter {
    
    private let openWeatherMapBaseURL = "http://api.openweathermap.org/data/2.5/weather"
    private let openWeatherMapAPIKey = "87e2404ee8d292175aed23920443ee3a"
    var weatherIsReady: Bool = false
    var weatherConditions: String = "No Conditions"
    
    func getWeather(city: String) {
        
        let session = URLSession.shared
        let weatherRequestURL = URL(string: "\(openWeatherMapBaseURL)?APPID=\(openWeatherMapAPIKey)&q=\(city)")!
        
        let dataTask = session.dataTask(with:weatherRequestURL) {
            (data, response, error) -> Void in
            if let error = error {
                print("Error:\n\(error)")
            }
            else {
                //print("Raw weather data:\n\(data!)\n")
                //let dataString = String(data: data!, encoding: String.Encoding.utf8)
                //print("weather data:\n\(dataString!)")
                do {
                    let weather = try JSONSerialization.jsonObject(
                        with: data!,
                        options: .mutableContainers) as! [String: AnyObject]
                    
                    print("City: \(weather["name"]!)")
                    print("Weather ID: \((weather["weather"]![0]! as! [String:AnyObject])["main"]!)")
                    print("Temperature: \(weather["main"]!["temp"]!!)")
                    let stringTemp = "\(weather["main"]!["temp"]!!)"
                    let intTemp = Float(stringTemp)
                    let temp = Int(ceil(intTemp! * 9.0/5.0 - 459.67))
                    self.weatherConditions = "\(temp)°F \((weather["weather"]![0]! as! [String:AnyObject])["main"]!)"
                }
                catch let jsonError as NSError {
                    // An error occurred while trying to convert the data into a Swift dictionary.
                    print("JSON error description: \(jsonError.description)")
                }
                print(self.weatherConditions)
                self.weatherIsReady = true
            }
        }
        
        dataTask.resume()
    }
    
}
