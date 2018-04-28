//
//  CharactersViewController.swift
//  MarvelTest
//
//  Created by Vlad on 27/04/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import UIKit

class CharactersTableViewController: UITableViewController, CharacterViewCellProtocol {
   
    // loading view
    var spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    var loadingView: UIView = UIView()
    
    var charactersArray = [Character]()
    
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
        
        startGetCharactersApi()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationItem.title = "Characters"
        let attributes = [NSAttributedStringKey.font : UIFont(name: "Helvetica Neue", size: 18)!, NSAttributedStringKey.foregroundColor : UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 238/255, green: 18/255, blue: 28/255, alpha: 1.0)
    }
    
    func startGetCharactersApi() {
        self.showActivityIndicator()
        
        requestGetCharactersApi( completionHandler: { ( successfullyCompleted) -> Void in
            
            self.hideActivityIndicator()
            
            if successfullyCompleted {
                self.tableView.reloadData()
            }
        })
        
    }
    
    func requestGetCharactersApi(completionHandler: @escaping (_ successfullyCompleted: Bool) -> ()) {
        
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
    
    func parseCharactersJson(responseObject : [String : Any], completionHandler: @escaping (_ completed: Bool) -> ()) {
        
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
    
    func learnMoreBtnPressed(sender: UIButton) {
        selectedIndex = sender.tag
        self.performSegue(withIdentifier: "showViewCharacter", sender: self)
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charactersArray.count
    }
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath) as! CharacterTableViewCell
     
        cell.selectionStyle = .none
        cell.delegate = self
        cell.setCharacter(character: charactersArray[indexPath.row])
        cell.setupViews()
        cell.moreButton.tag = indexPath.row
        cell.separatorInset = UIEdgeInsets(top: 0, left: 20 , bottom: 0, right: 0)
     
        return cell
     }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        self.performSegue(withIdentifier: "showViewCharacter", sender: self)
    }

    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
        if let vc = segue.destination as? ViewCharacterViewController {
            vc.setCharacter(character: charactersArray[selectedIndex])
        }
        
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
            
            self.spinner.color = UIColor.red
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

