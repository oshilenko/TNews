//
//  ManagedObjectModel.swift
//  Tinkoff News
//
//  Created by Ольга Шиленко on 01.04.2018.
//  Copyright © 2018 Ольга Шиленко. All rights reserved.
//

import Foundation
import UIKit
import CoreData

final class ManagedObjectModel: NSObject {
    
    static let shared: ManagedObjectModel = ManagedObjectModel()
    
    fileprivate var managedContext: NSManagedObjectContext!
    fileprivate var newsShortEntity: NSEntityDescription!
    fileprivate var newsContentEntity: NSEntityDescription!
    fileprivate var publicationDateEntity: NSEntityDescription!
    
    
    // MARK: - Private methods
    private override init() {
        super.init()
    }
}

extension ManagedObjectModel {
    func start() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        managedContext = appDelegate.persistentContainer.viewContext
        newsShortEntity = NSEntityDescription.entity(forEntityName: "NewsShortModel", in: managedContext)!
        newsContentEntity = NSEntityDescription.entity(forEntityName: "NewsContentModel", in: managedContext)!
        publicationDateEntity = NSEntityDescription.entity(forEntityName: "PublicationDateModel", in: managedContext)!
    }
    
    func write(newsShort: NewsShort) -> NSManagedObject {
        let newsShortObject = NSManagedObject(entity: newsShortEntity, insertInto: managedContext)
        newsShortObject.setValue(newsShort.bankInfoTypeId,  forKey: "bankInfoTypeId")
        newsShortObject.setValue(newsShort.id,              forKey: "id")
        newsShortObject.setValue(newsShort.name,            forKey: "name")
        newsShortObject.setValue(newsShort.text,            forKey: "text")
        
        if let publicationDate = newsShort.publicationDate {
            let publicationDateObject = write(publicationDate: publicationDate)
            newsShortObject.setValue(publicationDateObject, forKey: "publicationDate")
        }
        
        return newsShortObject
    }
    
    func write(publicationDate: PublicationDate) -> NSManagedObject {
        let publicationDateObject = NSManagedObject(entity: publicationDateEntity, insertInto: managedContext)
        publicationDateObject.setValue(publicationDate.milliseconds,  forKey: "milliseconds")
        
        return publicationDateObject
    }
    
    func readNewsShort(limit: Int) -> [NewsShortModel]? {
        let newsShortFetch = NSFetchRequest<NSFetchRequestResult>.init(entityName: newsShortEntity.name!)
        newsShortFetch.fetchLimit = limit
        
        guard let news = try? managedContext.fetch(newsShortFetch) else { return nil }
        
        return news as? [NewsShortModel]
    }
    
    func saveContext() {
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}
