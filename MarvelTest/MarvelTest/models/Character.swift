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
    var modified : Double?
    var thumbnail : Thumbnail?
    var detailURL : String?
    
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
        
        if let s = json["modified"] as? String {
            let date = s.toDate()
            let unixTime = date.getUnixTime()
            self.modified = unixTime
        }
        
        if let s = json["thumbnail"] as? NSDictionary {
            let thumbnail = Thumbnail(path: s["path"] as! String, imgExtension: s["extension"] as! String)
            self.thumbnail = thumbnail
        }
        
        if let urls = json["urls"] as? [NSDictionary] {
            for urlObject in urls {
                let url = Url(type : urlObject["type"] as! String, url : urlObject["url"] as! String)
                if url.getType() == "detail" {
                    self.detailURL = url.getURL()
                    break
                }
            }
        }
        
    }
    
    init(mCharacter : MCharacter) {
        
        self.id = Int(mCharacter.id)
        self.name = mCharacter.name
        self.description = mCharacter.mDescription
        self.detailURL = mCharacter.detailURL
        self.modified = mCharacter.modified
        
        if let path = mCharacter.thumbnailPath {
            if let tExtension = mCharacter.thumbnailExtension {
                   self.thumbnail = Thumbnail(path: path, imgExtension: tExtension)
            }
            
        }
     

    }
    
    // getters
    func getID() -> Int {
        return id!
    }
    
    func getName() -> String {
        return name!
    }
    
    func getDescription() -> String? {
        return description
    }
    
    func getModified() -> Double {
        return modified!
    }
    
    func getThumbnail() -> Thumbnail {
        return thumbnail!
    }
    
    func getDetailURL() -> String? {
        return detailURL
    }
    
}
