//
//  SplashViewController.swift
//  Netflix
//
//  Created by Emin Tolgahan Polat on 14.10.2022.
//

import UIKit
import RxSwift

class SplashViewController: UIViewController {
    let viewModel = container.resolve(SplashViewModel.self)!
    let disposeBag = DisposeBag()
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        viewModel.appname.observe(on: MainScheduler.instance).subscribe({item in
            print(item)
            self.titleLabel.text = item.element ?? ""
        }).disposed(by: disposeBag)
        viewModel.getAppName()
        
        
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(SplashViewController.nextPage))
        titleLabel.isUserInteractionEnabled = true
        titleLabel.addGestureRecognizer(tap)
    }
    
    
    @objc
    func nextPage(sender:UITapGestureRecognizer) {
        print("tıklandı")
        if viewModel.checkInternet(){
            print("İnternet Var")
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
                print("Sayfa Geç")
                let home = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "HomeVC") as! HomeViewController
             
                let nc = UINavigationController(rootViewController: home)
                nc.modalPresentationStyle = .fullScreen
                self.present(nc, animated: true)
              
            }
        }else {
          showAlert(title: "İnternet Bağlantısnı Kontrol ediniz", message: nil, actions: nil)
        }
        
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension UIViewController{
    func showAlert(title:String?,message:String?,actions:[UIAlertAction]?){
        let alert =  UIAlertController( title: title, message: message, preferredStyle: .alert)
        
        if (actions != nil){
            for item in actions! {
                alert.addAction(item)
            }
        }else{
            alert.addAction(UIAlertAction(title: "Tamam", style: .default))
        }
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
}
