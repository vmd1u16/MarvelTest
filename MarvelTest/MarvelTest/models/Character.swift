//
//  Character.swift
//  MarvelTest
//
//  Created by Vlad on 27/04/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import Foundation


class Character {
    
    var id : Int?
    var name : String?
    var description : String?
    var thumbnail : Thumbnail?
    
    init(json : NSDictionary) {
       
        if let s = json["id"] as? Int {
            self.id = s
        }
        
        if let s = json["name"] as? String {
            self.name = s
        }
        
        if let s = json["description"] as? String {
            self.description = s
        }
        
        if let s = json["thumbnail"] as? NSDictionary {
            let thumbnail = Thumbnail(path: s["path"] as! String, imgExtension: s["extension"] as! String)
            self.thumbnail = thumbnail
        }
        
    }
    
}
