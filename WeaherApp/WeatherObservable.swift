//
//  WeatherObservable.swift
//  WeaherApp
//
//  Created by Niko Holopainen on 7.4.2020.
//  Copyright © 2020 Niko Holopainen. All rights reserved.
//

import Foundation

protocol WeatherObservable {
    mutating func register(observer: WeatherObserver)
    mutating func deRegister(observer: WeatherObserver)
    func updateWeather(weather: Weather)
}
