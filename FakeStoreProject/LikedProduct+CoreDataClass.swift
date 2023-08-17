//
//  LikedProduct+CoreDataClass.swift
//  FakeStoreProject
//
//  Created by Mac on 24/07/2023.
//
//

import Foundation
import CoreData

@objc(LikedProduct)
public class LikedProduct: NSManagedObject {

    @NSManaged public var id: Int32
    @NSManaged public var title: String
    @NSManaged public var price: Double
    @NSManaged public var desc: String
    @NSManaged public var category: String
    @NSManaged public var image: String
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<LikedProduct> {
        return NSFetchRequest<LikedProduct>(entityName: "LikedProduct")
    }
}
