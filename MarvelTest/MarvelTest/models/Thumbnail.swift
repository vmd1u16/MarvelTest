//
//  Thumbnail.swift
//  MarvelTest
//
//  Created by Vlad on 27/04/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import Foundation

struct Thumbnail {
    
    var path : String
    var imgExtension : String
    
    func getFullURL() -> String {
        return "\(self.path).\(self.imgExtension)"
    }
    
}
