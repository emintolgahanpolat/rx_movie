//
//  SplashViewModel.swift
//  Netflix
//
//  Created by Emin Tolgahan Polat on 14.10.2022.
//

import Foundation
import RxSwift


class SplashViewModel {
    public let appname :PublishSubject<String?> =  PublishSubject()
    
    
    private var _remoteDataSource:RemoteDataSource
    init(remoteDataSource:RemoteDataSource){
        self._remoteDataSource = remoteDataSource
    }
    
    func getAppName(){
        appname.onNext(_remoteDataSource.appName())
    }
    
    func checkInternet()-> Bool{
        return Connectivity.isConnectedToInternet()
    }
}
