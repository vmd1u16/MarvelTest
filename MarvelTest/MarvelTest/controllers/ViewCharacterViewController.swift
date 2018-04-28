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

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationItem.title = self.character.getName()
        let attributes = [NSAttributedStringKey.font : UIFont(name: "Helvetica Neue", size: 18)!, NSAttributedStringKey.foregroundColor : UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
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

}
