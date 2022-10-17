//
//  MovieRepositoryTests.swift
//  NetflixTests
//
//  Created by Emin Tolgahan Polat on 13.10.2022.
//

import XCTest
import RxSwift
@testable import Netflix

final class MovieRepositoryTests: XCTestCase {
    
    override func setUpWithError() throws {
    }
    
    override func tearDownWithError() throws {
       
    }
 

    
    func testExample() async  {
        setupDI(Environment.prod)
        let repo:MovieRepository = container.resolve(MovieRepository.self)!
      
        do{
            let res = try await repo.getData("test",pageCount: 0,scope: nil)

            print(res.totalResults ?? "boş")
        }catch{
            print("Error")
        }
//
//        let res2 =  await repo.getData2("test",pageCount: 0,scope: nil)
//        switch res2 {
//           case .success(let items):
//            print(items.totalResults ?? "")
//           case .failure(let error):
//            print(error)
//            print("error")
//           }
        
    }
    
    func testPerformanceExample() throws {
       
        self.measure {
          
        }
    }
    
}
