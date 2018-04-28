//
//  CharacterTableViewCell.swift
//  MarvelTest
//
//  Created by Vlad on 27/04/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import UIKit

protocol CharacterViewCellProtocol {
    func learnMoreBtnPressed(sender : UIButton)
}


class CharacterTableViewCell: UITableViewCell {

    var delegate : CharacterViewCellProtocol!
    var character : Character!
    
    var characterImageView: UIImageView = {
        
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor.lightGray
        imageView.image = UIImage(named: "empty_image")!
        return imageView
    }()
    
    var shadowView: UIImageView = {
        
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor.lightGray
        return imageView
    }()
    
    var moreButton : UIButton = {
        
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 15.0)
        button.tintColor = UIColor.white
        button.backgroundColor = UIColor.clear
        
        return button
        
    }()
    
    var nameLabel : UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 20.0)
        label.textColor = UIColor.black
        label.layer.masksToBounds = true
        label.text = "Marvel name"
        
        
        return label
        
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func setCharacter(character : Character) {
        self.character = character
    }
    
    func setupViews() {
        
        for subview in self.contentView.subviews {
            subview.removeFromSuperview()
        }
        
        self.contentView.addSubview(shadowView)
        self.contentView.addSubview(characterImageView)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(moreButton)
        
        moreButton.addTarget(self, action: #selector(learnMoreBtnPressed(sender:)), for: .touchUpInside)
        
        // set image to character image view
        let imageURL = self.character.getThumbnail().getFullURL()
        // load imageView async, if image was cached then is no need to get image from url,
        characterImageView.loadImageUsingCache(withUrl: imageURL)
        characterImageView.contentMode = .scaleAspectFill
        characterImageView.clipsToBounds = true
        
        // name label
        self.nameLabel.text = character.getName()
        
        setConstraints()
    }
    
    func setConstraints() {
        
        // character thumbnail image
        
        var aspectRatioConstraint = NSLayoutConstraint(item: characterImageView,
                                                       attribute: .height,
                                                       relatedBy: .equal,
                                                       toItem: characterImageView,
                                                       attribute: .width,
                                                       multiplier: (9/16),
                                                       constant: 0)
        
        
        characterImageView.addConstraint(aspectRatioConstraint)
        
        
        var leftConstraint = NSLayoutConstraint(item: characterImageView, attribute: NSLayoutAttribute.leading, relatedBy: .equal, toItem: self.contentView, attribute: NSLayoutAttribute.leading, multiplier: 1.0, constant: 20)
        
        var topConstraint = NSLayoutConstraint(item: characterImageView, attribute: NSLayoutAttribute.top, relatedBy: .equal, toItem: self.contentView, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 20)
        

        
        var rightConstraint = NSLayoutConstraint(item: characterImageView, attribute: NSLayoutAttribute.trailing, relatedBy: .equal, toItem: self.contentView, attribute: NSLayoutAttribute.trailing, multiplier: 1.0, constant: -20)
        
        
        self.contentView.addConstraints([leftConstraint, topConstraint, rightConstraint])
        
        // shadow view
        
        aspectRatioConstraint = NSLayoutConstraint(item: shadowView,
                                                       attribute: .height,
                                                       relatedBy: .equal,
                                                       toItem: shadowView,
                                                       attribute: .width,
                                                       multiplier: (9/16),
                                                       constant: 0)
        
        
        shadowView.addConstraint(aspectRatioConstraint)
        
        
        leftConstraint = NSLayoutConstraint(item: shadowView, attribute: NSLayoutAttribute.leading, relatedBy: .equal, toItem: self.contentView, attribute: NSLayoutAttribute.leading, multiplier: 1.0, constant: 24)
        
        topConstraint = NSLayoutConstraint(item: shadowView, attribute: NSLayoutAttribute.top, relatedBy: .equal, toItem: self.contentView,attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 24)
        
         rightConstraint = NSLayoutConstraint(item: shadowView, attribute: NSLayoutAttribute.trailing, relatedBy: .equal, toItem: self.contentView, attribute: NSLayoutAttribute.trailing, multiplier: 1.0, constant: -16)
        
        
        self.contentView.addConstraints([leftConstraint, topConstraint, rightConstraint])
        
        // name label
        
        leftConstraint = NSLayoutConstraint(item: nameLabel, attribute: NSLayoutAttribute.leading, relatedBy: .equal, toItem: self.characterImageView, attribute: NSLayoutAttribute.leading, multiplier: 1.0, constant: 0)
        
        topConstraint = NSLayoutConstraint(item: nameLabel, attribute: NSLayoutAttribute.top, relatedBy: .equal, toItem: self.characterImageView, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 20)
        
        let bottomConstraint = NSLayoutConstraint(item: nameLabel, attribute: NSLayoutAttribute.bottom, relatedBy: .equal, toItem: self.contentView, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: -20)
        
        
        var widthConstraint = NSLayoutConstraint(item: nameLabel, attribute: .width, relatedBy: .equal,toItem: self.contentView, attribute: .width, multiplier: 0.50, constant: 0.0)
        
        self.contentView.addConstraints([leftConstraint, topConstraint, bottomConstraint, widthConstraint])
        
        // more button
    
        let btnImage = UIImage(named: "btn_learnmore")!
        moreButton.setImage(btnImage, for: .normal)
        
        aspectRatioConstraint = NSLayoutConstraint(item: moreButton,
                                                   attribute: .height,
                                                   relatedBy: .equal,
                                                   toItem: moreButton,
                                                   attribute: .width,
                                                   multiplier: (btnImage.size.height / btnImage.size.width),
                                                   constant: 0)
        
        
        moreButton.addConstraint(aspectRatioConstraint)
        
        rightConstraint = NSLayoutConstraint(item: moreButton, attribute: NSLayoutAttribute.trailing, relatedBy: .equal, toItem: self.characterImageView, attribute: NSLayoutAttribute.trailing, multiplier: 1.0, constant: 0)
        
        let yConstraint = NSLayoutConstraint(item: moreButton, attribute: NSLayoutAttribute.centerY, relatedBy: .equal, toItem: self.nameLabel, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: 0)
       
        
        widthConstraint = NSLayoutConstraint(item: moreButton, attribute: .width, relatedBy: .equal,toItem: self.contentView, attribute: .width, multiplier: 0.33, constant: 0.0)
        
        self.contentView.addConstraints([rightConstraint, yConstraint, widthConstraint])
        
        
    }
    
    @objc func learnMoreBtnPressed(sender: UIButton) {
        delegate.learnMoreBtnPressed(sender: sender)
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
