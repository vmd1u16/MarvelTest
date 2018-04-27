//
//  CharactersViewController.swift
//  MarvelTest
//
//  Created by Vlad on 27/04/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import UIKit

class CharactersViewController: UIViewController {
    
    
    // loading view
    var spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    var loadingView: UIView = UIView()
    
    var charactersArray = [Character]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startGetCharactersApi()
        
    }
    
    func startGetCharactersApi() {
        self.showActivityIndicator()
        
        requestGetCharactersApi( completionHandler: { ( successfullyCompleted) -> Void in
            
            self.hideActivityIndicator()
        })
        
    }
    
    func requestGetCharactersApi(completionHandler: @escaping (_ successfullyCompleted: Bool?) -> ()) {
        
        APIService().requestGetApi(url: urlGetCharacters, params: nil, headers: nil, completionHandler: { (data, response, error) -> Void in
            
            
            DispatchQueue.main.async {
                
                
                if let error = error {
                    print(error)
                    showGeneralApiErrorAlert(vc: self)
                    completionHandler(false)
                }
                if let data = data
                {
                    do {
                        // JSON serialization
                        let jsonResponse = try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions()) as! [String:Any]
                        
                        print(jsonResponse)
                        
                        self.parseCharactersJson(responseObject: jsonResponse , completionHandler: { (completed) -> Void in
                            
                            completionHandler(completed)
                            
                        })
                    }
                    catch {
                        print(error)
                        
                        showGeneralApiErrorAlert(vc: self)
                        completionHandler(false)
                    }
                    
                    
                }
                
            }
        })
        
    }
    
    func parseCharactersJson(responseObject : [String : Any], completionHandler: @escaping (_ completed: Bool?) -> ()) {
        
        /*if self.refreshhControl.isRefreshing {
         adsArray.removeAll()
         }*/
        
        guard let dataObject = responseObject["data"] as? [String : Any] else {
            completionHandler(true)
            return
        }
        
        guard let charactersJson = dataObject["results"] as? [[String : Any]] else {
            completionHandler(true)
            return
        }
        
        // get charactersjson from results
        
        
        for characterJson in charactersJson {
            let character = Character(json : characterJson as NSDictionary)
            charactersArray.append(character)
        }
        
        
        
        
        completionHandler(true)
    }
    
    func showActivityIndicator() {
        DispatchQueue.main.async {
            
            self.loadingView = UIView()
            self.loadingView.frame = CGRect(x: 0.0, y: 0.0, width: 50.0, height: 50.0)
            self.loadingView.center = self.view.center
            self.loadingView.backgroundColor = UIColor.clear
            self.loadingView.alpha = 0.7
            self.loadingView.clipsToBounds = true
            self.loadingView.layer.cornerRadius = 10
            
            self.spinner.color = UIColor.darkGray
            self.spinner.frame = CGRect(x: 0.0, y: 0.0, width: 30.0, height: 30.0)
            self.spinner.center = CGPoint(x:self.loadingView.bounds.size.width / 2, y:self.loadingView.bounds.size.height / 2)
            
            self.loadingView.addSubview(self.spinner)
            self.view.addSubview(self.loadingView)
            self.spinner.startAnimating()
            
        }
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
            self.loadingView.removeFromSuperview()        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

