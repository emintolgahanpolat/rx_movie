//
//  DataSource.swift
//  Netflix
//
//  Created by Emin Tolgahan Polat on 14.10.2022.
//

import Foundation
protocol LocalDataSource{
    func clear()
}


class LocalDataSourceImpl :LocalDataSource{
    
    
    let defaults = UserDefaults.standard
    
    func clear() {
        let dictionary = defaults.dictionaryRepresentation()
            dictionary.keys.forEach { key in
                defaults.removeObject(forKey: key)
            }
    }
//    func getObecjet() -> AppSettings? {
//        if let savedPerson = defaults.object(forKey: "AppSettings") as? Data {
//
//            if let data = try? JSONDecoder().decode(AppSettings.self, from: savedPerson) {
//               return data
//            }
//            return nil
//        }
//        return nil
//    }
//
//    func setObject(settings: AppSettings?) {
//        let encoder = JSONEncoder()
//        if let encoded = try? encoder.encode(settings) {
//            defaults.set(encoded, forKey: "AppSettings")
//        }
//    }
//
    
}
