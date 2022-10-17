//
//  AppNetwork.swift
//  Netflix
//
//  Created by Emin Tolgahan Polat on 13.10.2022.
//

import Foundation
import Alamofire


class AppNetwork{
    
    private var baseUrl:String?
    private var _session: Session
    init(_ session:Session,baseUrl:String?){
        self._session = session
        self.baseUrl = baseUrl 
    }
    /// TODO : Response tipi Result tarzı bir yapıda kurulabilir.
    func request<T: Decodable>(_ url: String,
                                     type: T.Type,
                                     method: HTTPMethod,
                                     parameters: Parameters? = nil) async throws -> T {
        
         try await _session.request((baseUrl ?? "")+url,
                                         method: method,
                                         parameters: parameters,
                                         encoding: URLEncoding.default)
          .serializingDecodable(type).value
      }
    
   
}
