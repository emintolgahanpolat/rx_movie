//
//  HomeViewController.swift
//  Netflix
//
//  Created by Emin Tolgahan Polat on 13.10.2022.
//

import UIKit
import RxSwift
import RxCocoa


class HomeViewController: UIViewController, UIScrollViewDelegate {
    
    var viewModel = container.resolve(HomeViewModel.self)!
    let disposeBag = DisposeBag()
    
    private lazy var refreshControl : UIRefreshControl={
        let mRefreshControl = UIRefreshControl()
        mRefreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return mRefreshControl
        
    }()
    
    private lazy var collectionView:UICollectionView = {
        let mCollectionView = UICollectionView(frame: CGRect.zero,collectionViewLayout: UICollectionViewFlowLayout())
        
        mCollectionView.backgroundColor = .systemBackground
        mCollectionView.translatesAutoresizingMaskIntoConstraints = false
        mCollectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        mCollectionView.alwaysBounceVertical = true
        mCollectionView.addSubview(refreshControl)
        
        return mCollectionView
    }()
    
    //    lazy var searchViewContrroller:SearchViewController={
    //        var mSearchViewContrroller = SearchViewController()
    //        mSearchViewContrroller.mNavigationController = navigationController
    //        return mSearchViewContrroller
    //    }()
    
    private lazy var searchController :UISearchController = {
        let mSearchController = UISearchController(searchResultsController: nil)
        
        mSearchController.searchResultsUpdater = self
        mSearchController.obscuresBackgroundDuringPresentation = false
        mSearchController.searchBar.enablesReturnKeyAutomatically = false
        mSearchController.searchBar.returnKeyType = UIReturnKeyType.done
        mSearchController.searchBar.placeholder = "Film Ara"
        mSearchController.searchBar.sizeToFit()
        mSearchController.searchBar.delegate = self
        //        mSearchController.searchBar.scopeButtonTitles = VideoType.allValue
        definesPresentationContext = true
        return mSearchController
    }()
    
    @objc func refresh() async{
        
        await viewModel.getData("star")
    }
    
    
    private func setupUI(){
        title = "loodos"
        navigationItem.searchController = searchController
        
        view.addSubview(collectionView)
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        collectionView.rx.modelSelected(Movie.self).subscribe(onNext: {
            item in
            
            print(item.imdbID ?? "" )
            let vc = DetailViewController()
            vc.imdbID = item.imdbID
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: disposeBag)
        
        
    }
    override func viewDidLoad()  {
        super.viewDidLoad()
        setupUI()
        
        
        
        viewModel.list.bind(to: collectionView.rx.items(cellIdentifier: "MyCell", cellType: MovieCollectionViewCell.self)) { (row,item,cell) in
            cell.posterImageView.loadImage(item.poster)
        }.disposed(by: disposeBag)
        
        viewModel.list.observe(on: MainScheduler.instance).subscribe({item in
            self.collectionView.reloadData()
            self.refreshControl.endRefreshing()
            
        }).disposed(by: disposeBag)
        
        Task{
            await refresh()
        }
    }
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        if(indexPath.row == 0){
            return CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.width * (4/3))
        }
        let width = (self.collectionView.frame.width - 10 ) / 2
        return CGSize(width: width, height: width * (4/3))
    }
}
extension HomeViewController: UISearchResultsUpdating ,UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text ?? "searchController")
        Task{
            await viewModel.getData(searchController.searchBar.text ?? "")
        }
        
    }
    //
    //    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
    //        //VideoType.allValue[selectedScope]
    //
    //        Task{
    //            await viewModel.getData(searchController.searchBar.text ?? "")
    //        }
    //
    //    }
}
