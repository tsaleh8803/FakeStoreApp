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

    @NSManaged public var id: Int16
    @NSManaged public var title: String?
    @NSManaged public var price: Double
    @NSManaged public var desc: String?
    @NSManaged public var category: String?
    @NSManaged public var image: String?
    @NSManaged public var isLiked: Bool
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<LikedProduct> {
        return NSFetchRequest<LikedProduct>(entityName: "LikedProduct")
    }
}
