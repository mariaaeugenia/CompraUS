
import Foundation
import RealmSwift

struct StateReposioty: Repository {
    
    typealias T = State
    let realm = try! Realm()
    
    func save(object: State) {
        try! realm.write {
            realm.add(object)
        }
    }
    
    func fetch(completion: @escaping (([State]) -> Void)) {
        let result = realm.objects(State.self).toArray(type: State.self)
        let sortedByName = result.sorted { $0.name.lowercased() < $1.name.lowercased() }
        completion(sortedByName)
    }
    
    func delete(object: State) {
        try! realm.write {
            realm.delete(object)
        }
    }
    
    func update(object: State) {}
    
    func query(name: String) -> [State]? {
        return nil
    }
}
