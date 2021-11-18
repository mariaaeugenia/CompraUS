import Foundation

protocol ProductPresentable: AnyObject {
    func relodTableView()
}

class ShoppingViewModel: ViewModel {
    
    let productRepository = ProductRepository()
    var products = [Product]()
    
    weak var presenter: ProductPresentable?
    
    var productsNumberOfRows: Int {
        get { return products.count }
    }
    
    required init() {
        getProducts()
    }
    
    func viewModelLoad() {
        getProducts()
    }
    
    private func getProducts() {
        productRepository.fetch { [weak self] result in
            self?.products = result
            self?.presenter?.relodTableView()
        }
    }
    
    func getProduct(at index: Int) -> Product {
        let prod = products[index]
        return prod
    }
    
    func didSelect(at index: Int) -> Product {
        return products[index]
    }
}
