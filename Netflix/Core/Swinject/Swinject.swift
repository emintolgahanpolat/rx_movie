//
//  Swinject.swift
//  Netflix
//
//  Created by Emin Tolgahan Polat on 13.10.2022.
//

import Foundation
import Alamofire
import Swinject
import Firebase

enum Environment{
    case prod
    case dev
}


var container = Container()
func setupDI(_ environment:Environment) {

    container.register(LocalDataSource.self) { _ in
        LocalDataSourceImpl()
    }
    
    if(environment == Environment.prod){
        container.register(AppConfig.self) { _ in
            ProdAppConfig()
        }
    }
    if(environment == Environment.dev){
        container.register(AppConfig.self) { _ in
            DevAppConfig()
        }
    }
    let appModule = AppModule()
    container.register(AppNetwork.self) { _ in  appModule.alamofire }.inObjectScope(.container)
    container.register(RemoteConfig.self) { _ in  appModule.remoteConfig }.inObjectScope(.container)

    container.register(RemoteDataSource.self) { r in
        RemoteDataSourceImpl(r.resolve(RemoteConfig.self)!)
    }.inObjectScope(.container)
    
    if(environment == Environment.prod || environment == Environment.dev){
        container.register(MovieRepository.self) { r in
            MovieRepositoryImpl(service:( r.resolve(AppNetwork.self)!),appConfig: r.resolve(AppConfig.self)!)
        }
    }
    container.register(HomeViewModel.self) { r in
        HomeViewModel(movieRepository: r.resolve(MovieRepository.self)!)
    }
    
    container.register(SplashViewModel.self) { r in
        SplashViewModel(remoteDataSource: r.resolve(RemoteDataSource.self)!)
    }
    
    container.register(DetailViewModel.self) { r in
        DetailViewModel(movieRepository: r.resolve(MovieRepository.self)!)
    }
    
}

