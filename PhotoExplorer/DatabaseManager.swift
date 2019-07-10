//
//  DatabaseManager.swift
//  PhotoExplorer
//
//  Created by Bryan A Bolivar M on 7/10/19.
//  Copyright © 2019 Bolivarbryan. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DatabaseManager {

    static let shared = DatabaseManager()
    private let photoEntity = "PhotoEntity"

    private init() { }

    func save(photo: Photo) {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }

        let managedContext = appDelegate.persistentContainer.viewContext

        let entity = NSEntityDescription.entity(forEntityName: photoEntity, in: managedContext)!

        let photoManagedObject = NSManagedObject(entity: entity, insertInto: managedContext)

        photoManagedObject.setValue(photo.pictureURL, forKeyPath: "pictureURL")
        photoManagedObject.setValue(photo.source, forKeyPath: "source")
        photoManagedObject.setValue(photo.description, forKeyPath: "caption")

        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }

    func fetchAllPhotos() -> [Photo] {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate
            else { return [] }

        let managedContext =
            appDelegate.persistentContainer.viewContext
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: photoEntity)

        do {
           let photos = try managedContext.fetch(fetchRequest) as? [PhotoEntity]

            let pics = photos!.compactMap { photo in
                return Photo.reverseParse(photo: photo)
            }

            return pics

        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }
}
