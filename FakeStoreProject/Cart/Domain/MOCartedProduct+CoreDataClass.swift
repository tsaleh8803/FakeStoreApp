//
//  CartedProduct+CoreDataClass.swift
//  FakeStoreProject
//
//  Created by Mac on 18/08/2023.
//
//

import Foundation
import CoreData

@objc(MOCartProduct)
public class MOCartProduct: NSManagedObject {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<MOCartProduct> {
        return NSFetchRequest<MOCartProduct>(entityName: "MOCartProduct")
    }

    @NSManaged public var image: String
    @NSManaged public var price: Double
    @NSManaged public var title: String
    @NSManaged public var category: String
    @NSManaged public var desc: String
    @NSManaged public var id: Int32

}