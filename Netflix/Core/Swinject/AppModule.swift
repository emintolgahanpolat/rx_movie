//
//  AppModule.swift
//  Netflix
//
//  Created by Emin Tolgahan Polat on 13.10.2022.
//

import Foundation
import Alamofire
import Firebase

class AppModule{
    
    
      let alamofire: AppNetwork = {
         let configuration = URLSessionConfiguration.af.default
         configuration.timeoutIntervalForRequest = 30
         
          return AppNetwork(Session(configuration: configuration,interceptor: AlamofireHeader(), eventMonitors: [AlamofireLogger()]),baseUrl: container.resolve(AppConfig.self)!.baseUrl)
        
     }()
    
    
    var remoteConfig:RemoteConfig {
        let remoteConfig = RemoteConfig.remoteConfig()
                let settings = RemoteConfigSettings()
                settings.minimumFetchInterval = 0
                remoteConfig.configSettings = settings
                remoteConfig.fetchAndActivate()
        return remoteConfig
    }
}

