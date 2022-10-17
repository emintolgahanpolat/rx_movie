//
//  DetailViewController.swift
//  Netflix
//
//  Created by Emin Tolgahan Polat on 14.10.2022.
//

import UIKit
import RxSwift

class DetailViewController: UIViewController {

    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var metascore: UILabel!
    @IBOutlet weak var about: UILabel!

    var imdbID:String? = nil

    var viewModel = container.resolve(DetailViewModel.self)!
    
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.movie.observe(on: MainScheduler.instance)
            .subscribe(onNext: { (i) in
                self.poster.loadImage(i.poster)
                self.movieTitle.text = i.title
                self.rating.text = i.imdbRating
                self.metascore.text = i.ratings?.last?.value
                self.about.text = i.plot
            }).disposed(by: disposeBag)
        
        
        
      
        
        Task{
            await viewModel.fetchData(imdbID!)
        }

    }


    
    
}
