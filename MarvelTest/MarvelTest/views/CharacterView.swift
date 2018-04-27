//
//  CharacterView.swift
//  MarvelTest
//
//  Created by Vlad on 27/04/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import UIKit

class CharacterView: UIView {
    
    var scrollView: UIScrollView!
    var parentView: UIView!
    
    var character : Character!
    
    var characterImageView: UIImageView = {
        
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor.lightGray
        imageView.image = UIImage(named: "empty_image")!
        return imageView
    }()
    
    var linkButton : UIButton = {
        
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 15.0)
        button.tintColor = UIColor.white
        button.backgroundColor = UIColor.red
        button.setTitle("READ MORE ONLINE", for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        button.contentVerticalAlignment = .center
        
        return button
        
    }()
    
    var nameLabel : UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 28.0)
        label.textColor = UIColor.black
        label.layer.masksToBounds = true
        label.text = "Marvel name"
        label.numberOfLines = 0
        
        return label
        
    }()
    
    var descriptionLabel : UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica Neue", size: 20.0)
        label.textColor = UIColor.black
        label.layer.masksToBounds = true
        label.text = "There is no description needed"
        label.numberOfLines = 0
        
        return label
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup(character : Character, scrollView : UIScrollView, parentView :  UIView) {
        self.character = character
        self.scrollView = scrollView
        self.parentView = parentView
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.scrollView.addSubview(self)
        
        let leftConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.leading, relatedBy: .equal, toItem: self.scrollView,
                                                attribute: NSLayoutAttribute.leading, multiplier: 1.0, constant: 0)
        
        let topConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.top, relatedBy: .equal, toItem: self.scrollView,
                                               attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 0)
        
        let rightConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.trailing, relatedBy: .equal, toItem: self.scrollView,
                                                 attribute: NSLayoutAttribute.trailing, multiplier: 1.0, constant: 0)
        
        let bottomConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.bottom, relatedBy: .equal, toItem: self.scrollView,
                                                  attribute: NSLayoutAttribute.bottom, multiplier: 1.0,
                                                  constant: 0)
        
        self.scrollView.addConstraints([leftConstraint, rightConstraint, topConstraint, bottomConstraint])
        
        let widthConstraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal,
                                                 toItem: self.parentView, attribute: .width,
                                                 multiplier: 1, constant: 0.0)
        
        self.parentView.addConstraint(widthConstraint)
        
        
    }
    
    func setupViews() {
        
        self.addSubview(characterImageView)
        self.addSubview(nameLabel)
        self.addSubview(descriptionLabel)
        self.addSubview(linkButton)
        
        // set image to character image view
        let imageURL = self.character.getThumbnail().getFullURL()
            
        // load imageView async and get the aspect ratio from the downloaded image
        characterImageView.loadImageGetRatio(withUrl: imageURL, completionHandler: { ( ratio ) -> Void in
            
            guard ratio != nil else {
                return
            }
            
            let aspectRatioConstraint = NSLayoutConstraint(item: self.characterImageView,attribute: .height,
                                                           relatedBy: .equal,toItem: self.characterImageView, attribute: .width, multiplier: ratio!, constant: 0)
            
            
            self.characterImageView.addConstraint(aspectRatioConstraint)
            
            
        })
        
        // name label
        self.nameLabel.text = character.getName()
        
        if let description = character.getDescription(), (description != "" && description != "null"){
            self.descriptionLabel.text = description
        }
        
        setConstraints()
        
    }
    
    func setConstraints() {
        
        // character thumbnail image
        
        
        var leftConstraint = NSLayoutConstraint(item: characterImageView, attribute: NSLayoutAttribute.leading, relatedBy: .equal, toItem: self, attribute: NSLayoutAttribute.leading, multiplier: 1.0, constant: 20)
        
        var topConstraint = NSLayoutConstraint(item: characterImageView, attribute: NSLayoutAttribute.top, relatedBy: .equal, toItem: self, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 20)
        
        
        
        var rightConstraint = NSLayoutConstraint(item: characterImageView, attribute: NSLayoutAttribute.trailing, relatedBy: .equal, toItem: self, attribute: NSLayoutAttribute.trailing, multiplier: 1.0, constant: -20)
        
        
        self.addConstraints([leftConstraint, topConstraint, rightConstraint])
        
        
        // name label
        
        leftConstraint = NSLayoutConstraint(item: nameLabel, attribute: NSLayoutAttribute.leading, relatedBy: .equal, toItem: self.characterImageView, attribute: NSLayoutAttribute.leading, multiplier: 1.0, constant: 20)
        
        rightConstraint = NSLayoutConstraint(item: nameLabel, attribute: NSLayoutAttribute.trailing, relatedBy: .equal, toItem: self.characterImageView, attribute: NSLayoutAttribute.trailing, multiplier: 1.0, constant: -20)
        
        topConstraint = NSLayoutConstraint(item: nameLabel, attribute: .top, relatedBy: .equal, toItem: characterImageView, attribute: .bottom, multiplier: 1.0, constant: 20)
        
        self.addConstraints([leftConstraint, topConstraint, rightConstraint])
        
        // description label
        
        leftConstraint = NSLayoutConstraint(item: descriptionLabel, attribute: NSLayoutAttribute.leading, relatedBy: .equal, toItem: self.nameLabel, attribute: NSLayoutAttribute.leading, multiplier: 1.0, constant: 0)
        
        rightConstraint = NSLayoutConstraint(item: descriptionLabel, attribute: NSLayoutAttribute.trailing, relatedBy: .equal, toItem: self.characterImageView, attribute: NSLayoutAttribute.trailing, multiplier: 1.0, constant: -35)
        
        topConstraint = NSLayoutConstraint(item: descriptionLabel, attribute: .top, relatedBy: .equal, toItem: nameLabel, attribute: .bottom, multiplier: 1.0, constant: 20)
        
        self.addConstraints([leftConstraint, rightConstraint, topConstraint])
        
        // read more online button
        
        let xConstraint = NSLayoutConstraint(item: linkButton, attribute: NSLayoutAttribute.centerX, relatedBy: .equal, toItem: self, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0)
        
        topConstraint = NSLayoutConstraint(item: linkButton, attribute: NSLayoutAttribute.top, relatedBy: .equal, toItem: self.descriptionLabel, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 40)
        
        let bottomConstraint = NSLayoutConstraint(item: linkButton, attribute: NSLayoutAttribute.bottom, relatedBy: .equal, toItem: self, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: -40)
        
        self.addConstraints([xConstraint, topConstraint, bottomConstraint])
        
    }
    
    
}
