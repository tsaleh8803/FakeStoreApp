
import Foundation
import CoreData

@objc(MOLikedProduct)
public class MOLikedProduct: NSManagedObject {

    @NSManaged public var id: Int32
    @NSManaged public var title: String
    @NSManaged public var price: Double
    @NSManaged public var desc: String
    @NSManaged public var category: String
    @NSManaged public var image: String
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<MOLikedProduct> {
        return NSFetchRequest<MOLikedProduct>(entityName: "MOLikedProduct")
    }
}
