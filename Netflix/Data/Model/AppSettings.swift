//
//  FirebaseAppConfig.swift
//  Netflix
//
//  Created by Emin Tolgahan Polat on 14.10.2022.
//

import Foundation

struct AppSettings: Codable {
    let name,color:String?
    
    enum CodingKeys: String, CodingKey {
        case name = "app_name"
        case color = "app_color"
    }
}
