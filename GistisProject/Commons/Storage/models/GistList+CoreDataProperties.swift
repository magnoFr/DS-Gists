//
//  GistList+CoreDataProperties.swift
//  
//
//  Created by Magno Augusto Ferreira Ruivo on 24/12/20.
//
//

import Foundation
import CoreData


extension GistList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GistList> {
        return NSFetchRequest<GistList>(entityName: "GistList")
    }

    @NSManaged public var gists: Data?

}
