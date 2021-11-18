
import RealmSwift

class Product: Object {
    
    @objc dynamic var id = ""
    @objc dynamic var name = ""
    @objc dynamic var image: Data?
    @objc dynamic var state: State?
    @objc dynamic var value: Double = 0.0
    @objc dynamic var isCreditCard = false
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
