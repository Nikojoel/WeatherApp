//
//  WeatherProvider.swift
//  WeaherApp
//
//  Created by Niko Holopainen on 7.4.2020.
//  Copyright © 2020 Niko Holopainen. All rights reserved.
//

import Foundation

struct WeatherProvider: WeatherObservable {
    
    var observers:[WeatherObserver] = []
    
    mutating func register(observer: WeatherObserver) {
        if observers.firstIndex(where: {($0 as AnyObject) === (observer as AnyObject)}) == nil {
            observers.append(observer)
        }
    }
    
    mutating func deRegister(observer: WeatherObserver) {
        if let index = observers.firstIndex(where: {($0 as AnyObject) === (observer as AnyObject)}) {
            observers.remove(at: index)
        }
    }
    
    func updateWeather(weather: Weather) {
        for observer in observers {
            observer.newWeather(weather: weather)
        }
    }
    
    
    func getCityWeather(_ city: String) {
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&units=metric\(Keys.ApiKey.rawValue)") else {
            fatalError("Failed to create url")
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("fetch city weather error... \(error)")
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    print("error in httpresponse...")
                    return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let weather = try decoder.decode(Weather.self, from: data)
                    self.updateWeather(weather: weather)
                    
                } catch let err {
                    print("Eroorrr", err)
                }
            }
        }
        task.resume()
    }

}
