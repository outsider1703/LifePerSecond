//
//  CoreDataManager.swift
//  LifePerSecond
//
//  Created by Macbook on 01.10.2020.
//  Copyright © 2020 Igor Simonov. All rights reserved.
//

import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    private init() {}
    
    private var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "LifePerSecondData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

//MARK: - Core Data Functions
extension CoreDataManager {
    
    func getAnObject() -> Task? {
        guard let entityDescription = NSEntityDescription.entity(
            forEntityName: "Task",
            in: viewContext
            ) else { return nil }
        guard let task = NSManagedObject(
            entity: entityDescription,
            insertInto: viewContext
            ) as? Task else { return nil }
        return task
    }
    
    func save(_ newTask: Task) {
        saveContext()
    }
    
    func delete(_ deleteTask: Task) {
        viewContext.delete(deleteTask)
        saveContext()
    }
    
    func fetchData() -> [Task] {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        var tasks = [Task]()
        
        do {
            tasks = try viewContext.fetch(fetchRequest)
        } catch let error {
            print(error)
        }
        return tasks
    }
    
    func editName(_ task: Task, newName: String) {
        task.name = newName
        saveContext()
    }
    //MARK:- {{{
    func updateTime(_ task: Task, newTime: Int64) {
        
        let dateObject = TimeAndDate(context: viewContext)
        dateObject.date = Date()
        dateObject.timeCounter = newTime
        
        let newTimeSetForTask = task.setTimeAndDate?.mutableCopy() as? NSMutableOrderedSet
        newTimeSetForTask?.add(dateObject)
        task.setTimeAndDate = newTimeSetForTask
        
        saveContext()
    }
    //MARK:- }}} Переделать
    
}

