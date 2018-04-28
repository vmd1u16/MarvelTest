//
//  ViewCharacterViewController.swift
//  MarvelTest
//
//  Created by Vlad on 27/04/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import UIKit

class ViewCharacterViewController: UIViewController, CharacterViewProtocol {
    
    @IBOutlet weak var scrollView: UIScrollView!
    var characterView = CharacterView()
    
    var character : Character!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        navigationController?.navigationBar.tintColor = .white
        
        setupViews()
    }
    
    func setupViews() {
        
        characterView.delegate = self
        characterView.setup(character: character, scrollView: scrollView, parentView: self.view)
        characterView.setupViews()
        
    }
    
    func setCharacter(character : Character) {
        self.character = character
    }
    
    func linkBtnPressed(urlString: String) {
        if let url = URL(string: urlString){
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
