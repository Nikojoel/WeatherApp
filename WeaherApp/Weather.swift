//
//  Weather.swift
//  WeaherApp
//
//  Created by Niko Holopainen on 7.4.2020.
//  Copyright © 2020 Niko Holopainen. All rights reserved.
//

    import Foundation
    import UIKit

    struct Weather:Codable {
        var weather:[WeatherType]
        var main: MainInfo
        var wind:[String:Double]
        var name:String
    }

    struct WeatherType:Codable {
        var description:String
    }

    struct MainInfo:Codable {
        var temp:Double
        var temp_min:Double
        var temp_max:Double
    }
