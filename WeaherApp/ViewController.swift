//
//  ViewController.swift
//  WeaherApp
//
//  Created by Niko Holopainen on 7.4.2020.
//  Copyright © 2020 Niko Holopainen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, WeatherObserver, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    private var weatherProvider = WeatherProvider()

    private let cities = [
        "Helsinki",
        "Mogadishu",
        "Stockholm",
        "Oslo",
        "Austin",
        "Boston",
    ]
    
    // Register observer
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        weatherProvider.register(observer: self)
        weatherProvider.getCityWeather(cities[0])
        
    }
    
    // Deregister observer
    override func viewDidDisappear(_ animated: Bool) {
        weatherProvider.deRegister(observer: self)
    }
    
    // Observer
    func newWeather(weather: Weather) {
        DispatchQueue.main.async {
            self.cityLabel.text = weather.name
            self.descLabel.text = weather.weather[0].description
            self.tempLabel.text = "\(weather.main.temp) ℃"
            self.maxTempLabel.text = "Daily max \(weather.main.temp_max) ℃"
            self.minTempLabel.text = "Daily min \(weather.main.temp_min) ℃"
            self.windLabel.text = "Windspeed \(weather.wind["speed"] ?? 0 ) m/s"
        }
        
    }
        
    // Pickerview methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cities.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cities[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let city = cities[row]
        weatherProvider.getCityWeather(city)
    }
}

