//
//  AppConfig.swift
//  Netflix
//
//  Created by Emin Tolgahan Polat on 13.10.2022.
//

import Foundation


protocol AppConfig{
    var baseUrl:String { get }
    var key:String { get }
    var appName:String { get }
}

class ProdAppConfig : AppConfig{
    var baseUrl: String = "https://www.omdbapi.com"
    var key: String = "60d397e1"
    var appName: String = "Prod"
    
}

class DevAppConfig : AppConfig{
    var baseUrl: String = "https://www.omdbapi.com"
    var key: String = "60d397e1"
    var appName: String = "Dev"
}
