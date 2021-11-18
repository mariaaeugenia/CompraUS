
import Foundation

protocol Repository {
    associatedtype T
    func save(object: T)
    func fetch(completion: @escaping(([T]) -> Void))
    func delete(object: T)
    func update(object: T)
    func query(name: String) -> [T]?
}
