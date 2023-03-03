//
//  NSManagedObject+Extensions.swift
//  GistisProject
//
//  Created by Magno Augusto Ferreira Ruivo on 24/12/20.
//

import Foundation
import CoreData

public extension NSManagedObject {

    convenience init(context: NSManagedObjectContext) {
        let name = String(describing: type(of: self))
        let entity = NSEntityDescription.entity(forEntityName: name, in: context)!
        self.init(entity: entity, insertInto: context)
    }
}
