//
//  HomeViewModel.swift
//  Netflix
//
//  Created by Emin Tolgahan Polat on 13.10.2022.
//

import Foundation
import RxSwift

class HomeViewModel{
    let _movieRepository:MovieRepository
    init(movieRepository:MovieRepository){
        _movieRepository = movieRepository
    }
    
    public let list :PublishSubject<[Movie]> =  PublishSubject()
 

    func getData(_ keyword:String?) async  {
        var res:[Movie] = []
        do{
            res = try await _movieRepository.getData(keyword, pageCount: 1, scope: nil).search ?? []
        }catch{
            
        }
        list.onNext(res)
    }
    
}
