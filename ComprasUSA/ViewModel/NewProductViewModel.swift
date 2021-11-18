import Foundation

enum ButtonStatus {
    case save
    case edit
}

protocol NewProductPresentable: AnyObject {
    func reloadPickerView()
    func presentProduct(product: Product)
}

class NewProductViewModel: ViewModel {
    
    var editProduct: Product?
    var states = [State]()
    var selectedState = State()
    weak var presenter: NewProductPresentable?
    
    var buttonStatus: ButtonStatus = .save
    
    var statesNumberOfRows: Int {
        get { return states.count }
    }
    
    required init() {}
    
    func viewModelLoad() {
        getState()
        if let prod = editProduct {
            editProduct = prod
            presenter?.presentProduct(product: prod)
        }
    }
    
    func save(product: Product, completion: (() -> Void)) {
        let manager = ProductRepository()
        let newProduct = product
        if let id = editProduct?.id {
            newProduct.id = id
        } else {
            product.id = UUID().uuidString
        }
        if let state = editProduct?.state, selectedState.name.isEmpty {
            newProduct.state = state
        } else {
            newProduct.state = selectedState
        }
        
        switch buttonStatus {
        case .save:
             manager.save(object: newProduct)
        case .edit:
            manager.update(object: newProduct)
        }

        completion()
    }
    
    private func getState() {
        let manager = StateReposioty()
        manager.fetch { [weak self] result in
            self?.states = result
            self?.presenter?.reloadPickerView()
        }
    }
    
    func didSelectState(at index: Int) {
        if states.count > 0 && index < states.count{
            selectedState = states[index]
        }
    }
    
    func getStateNameSelected() -> String {
        return selectedState.name
    }
    
    func getButtonTitle() -> String {
        if editProduct != nil {
            buttonStatus = .edit
            return "EDITAR"
        }
        buttonStatus = .save
        return "CADASTRAR"
    }
    
}
