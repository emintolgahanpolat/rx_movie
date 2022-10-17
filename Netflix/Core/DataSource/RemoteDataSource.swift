//
//  RemoteDataSource.swift
//  Netflix
//
//  Created by Emin Tolgahan Polat on 14.10.2022.
//

import Foundation
import Firebase

protocol RemoteDataSource{
     func appName() -> String?
     func appColor() -> String?
}

class RemoteDataSourceImpl:RemoteDataSource{
    private var _remoteConfig: RemoteConfig
    init(_ remoteConfig:RemoteConfig){
        self._remoteConfig = remoteConfig
    }
    
    func appName() -> String? {
       return _remoteConfig["app_name"].stringValue
    }
    
     func appColor() -> String? {
        return _remoteConfig["app_color"].stringValue
    }
    
    
}
