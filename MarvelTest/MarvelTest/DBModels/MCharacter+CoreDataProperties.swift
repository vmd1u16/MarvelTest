//
//  MCharacter+CoreDataProperties.swift
//  MarvelTest
//
//  Created by Vlad on 28/04/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//
//

import Foundation
import CoreData


extension MCharacter {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<MCharacter> {
        return NSFetchRequest<MCharacter>(entityName: "MCharacter")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var mDescription: String?
    @NSManaged public var modified: Double
    @NSManaged public var thumbnailPath: String?
    @NSManaged public var thumbnailExtension: String?
    @NSManaged public var detailURL: String?

}
