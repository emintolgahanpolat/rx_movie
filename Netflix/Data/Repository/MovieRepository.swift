//
//  MovieRepository.swift
//  Netflix
//
//  Created by Emin Tolgahan Polat on 13.10.2022.
//

import Foundation
import Combine
import Alamofire


protocol MovieRepository{
    func getData(_ keyword:String?,pageCount:Int?, scope:VideoType?) async throws ->MovieSearchData
    func getWithImdbId(_ id:String) async throws -> Movie
    
    
}
class MovieRepositoryImpl:MovieRepository{
    
    private var _service: AppNetwork
    private var _appConfig:AppConfig
    init(service:AppNetwork,appConfig:AppConfig){
        self._service = service
        self._appConfig = appConfig
    }
    
    
    func getWithImdbId(_ id: String) async throws -> Movie {
        return try  await _service.request("/",type: Movie.self,method: .get,parameters: [
            "apikey":_appConfig.key,
            "i":id
        ])
    }
    
    func getData(_ keyword: String?,pageCount:Int?, scope:VideoType?) async throws -> MovieSearchData {
        return try  await _service.request("/",type: MovieSearchData.self,method: .get,parameters: [
            "apikey":_appConfig.key,
            "s":keyword ?? "",
            "page":pageCount ?? "",
            "type":scope?.rawValue ?? ""
        ])
        
    }
    
}


