//
//  HelperMethods.swift
//  MarvelTest
//
//  Created by Vlad on 27/04/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import Foundation
import UIKit

// created to store urls, api endpoints
// useful methods which will be used across more controllers

let urlGetCharacters = "http://bit.ly/tabtestmarvelcharacters"


func showGeneralApiErrorAlert(vc: UIViewController) {
    // create the alert
    let alert = UIAlertController(title: "Oh, bummer", message: "Some difficulties were encountered during the request. Please give it another try.", preferredStyle: UIAlertControllerStyle.alert)
    
    // add an action (button)
    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
    // show the alert
    vc.present(alert, animated: true, completion: nil)
}

func showCustomAlert(title : String , message : String, vc : UIViewController) {
    
    // create the alert
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
    
    // add an action (button)
    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
    // show the alert
    vc.present(alert, animated: true, completion: nil)
}
