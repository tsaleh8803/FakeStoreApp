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
    @NSManaged public var image: String
    @NSManaged public var price: Double
    @NSManaged public var title: String
    @NSManaged public var category: String
    @NSManaged public var desc: String
    @NSManaged public var id: Int32
    @NSManaged public var quantity: Int32

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MOCartProduct> {
        return NSFetchRequest<MOCartProduct>(entityName: "MOCartProduct")
    }
}
