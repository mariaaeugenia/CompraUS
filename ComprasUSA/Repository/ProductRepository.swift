import Foundation
import RealmSwift

class ProductRepository: Repository {
    
    typealias T = Product
    let realm = try! Realm()
    
    func save(object: Product) {
        try! realm.write {
            realm.add(object)
        }
    }
    
    func fetch(completion: @escaping (([Product]) -> Void)) {
        let result = realm.objects(Product.self).toArray(type: Product.self)
        completion(result)
    }
    
    func delete(object: Product) {
        try! realm.write {
            realm.delete(object)
        }
    }
    
    func update(object: Product) {
        try! realm.write {
            realm.add(object, update: .modified)
        }
    }
    
    func query(name: String) -> [Product]? {
        let products = realm.objects(Product.self).filter("state.name = '\(name)'")
        return products.toArray(type: Product.self)
    }
}
