//
//  LogInterceptor.swift
//  Netflix
//
//  Created by Emin Tolgahan Polat on 13.10.2022.
//

import Foundation
import Alamofire

class AlamofireHeader: RequestInterceptor{
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        //urlRequest.setValue("Bearer xxx", forHTTPHeaderField: "Authorization")
        completion(.success(urlRequest))
    }
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        
    }
}

class AlamofireLogger: EventMonitor {
    
    func requestDidFinish(_ request: Request) {
        debugPrint(request.description)
    }
    
    func request<Value>(
        _ request: DataRequest,
        didParseResponse response: DataResponse<Value, AFError>
    ) {
        
        debugPrint(response)
        
    }
}

