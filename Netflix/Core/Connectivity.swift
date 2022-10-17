//
//  Connectivity.swift
//  Netflix
//
//  Created by Emin Tolgahan Polat on 14.10.2022.
//

import Foundation
import Alamofire

class Connectivity {
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
