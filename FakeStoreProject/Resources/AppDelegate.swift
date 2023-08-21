//
//  AppDelegate.swift
//  temp
//
//  Created by Mac on 19/07/2023.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}

enum CoreDataContext {
    
    private static var _context: NSManagedObjectContext?
    
    static func context() -> NSManagedObjectContext {
        guard _context == nil else {
            return _context!
        }
        
        let container = NSPersistentCloudKitContainer(name: "FakeStoreProjectDataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        _context = container.viewContext
        
        return _context!
    }
}
