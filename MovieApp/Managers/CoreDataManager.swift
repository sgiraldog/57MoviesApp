//
//  CoreDataManager.swift
//  MovieApp
//
//  Created by Sebastián Giraldo Gómez on 7/05/21.
//

import UIKit
import CoreData

enum MovieKeys: String {
    case title
}
class CoreDataManager {
    static let shared = CoreDataManager()
    
    func createData(movie: MovieData) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        guard let movieEntity = NSEntityDescription.entity(forEntityName: "Movie", in: managedContext) else { return }
        
        let movieObject = NSManagedObject(entity: movieEntity, insertInto: managedContext)
        movieObject.setValue(movie.title, forKey: MovieKeys.title.rawValue)
        do {
            try managedContext.save()
        } catch let error {
            print("requestError".localized + error.localizedDescription)
        }
    }
    
    func fetchData() -> [NSManagedObject]{
        var result: [NSManagedObject] = []
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return result }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
        
        do {
            let queryResult = try managedContext.fetch(fetchRequest)
            result = queryResult as! [NSManagedObject]
        } catch let error {
            print("requestError".localized + error.localizedDescription)
        }
        return result
    }
    
    func isMovieInEntity(title: String) -> Bool{
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
        fetchRequest.predicate = NSPredicate(format: "title == %@", title)
        
        
        do {
            let result = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            return !result.isEmpty
        } catch let error {
            print("requestError".localized + error.localizedDescription)
        }
        return false
    }
    
    func deleteData(title: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
        fetchRequest.predicate = NSPredicate(format: "title == %@", title)
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            let object = result[0] as! NSManagedObject
            managedContext.delete(object)
            do {
                try managedContext.save()
            } catch let error {
                print("requestError".localized + error.localizedDescription)
            }
        } catch let error {
            print("requestError".localized + error.localizedDescription)
        }
    }
}
