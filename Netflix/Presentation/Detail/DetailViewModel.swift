//
//  DetailViewModel.swift
//  Netflix
//
//  Created by Emin Tolgahan Polat on 14.10.2022.
//

import Foundation
import RxSwift
import Firebase

class DetailViewModel{
    let _movieRepository:MovieRepository
    init(movieRepository:MovieRepository){
        _movieRepository = movieRepository
    }
    var movie : PublishSubject<Movie> = PublishSubject()
    
    func fetchData(_ imdbID:String) async{
        var res:Movie!
        do{
            Analytics.logEvent("movie_detail_open", parameters: [
                                "imdbID":imdbID])
            res = try await _movieRepository.getWithImdbId(imdbID)
        }catch{
            
        }
        movie.onNext(res)
  
        
        
    }
}


