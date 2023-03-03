//
//  DataManeger.swift
//  Drawing
//
//  Created by Magno Augusto Ferreira Ruivo on 28/11/20.
//

import Foundation
import CoreData

class DataManager {
    
    static var shared = DataManager()
    
    static var managedObjectContext = AppDelegate().persistentContainer.viewContext
    static var container = AppDelegate().persistentContainer

    static func encodeObject<T: Codable>(dataModel: T) -> Data? {
        return try? JSONEncoder().encode(dataModel)
    }

    static func decodeObject<T: Codable, N: DataProtocol>(type: T.Type, data: N) -> T?  {
        return try? JSONDecoder().decode(type, from: data as! Data)
    }
    
    static func save() {
        do {
            try managedObjectContext.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }

    static func fetch<T: NSManagedObject>(requestData: T.Type) -> [T] {
        let request = NSFetchRequest<T>(entityName: String(describing: T.self))
        let result = try? managedObjectContext.fetch(request)
        guard result != nil else { return [] }
        return result ?? []
    }

    static func delete<T: NSManagedObject>(data: T) {
        managedObjectContext.delete(data)
        save()
    }
}
