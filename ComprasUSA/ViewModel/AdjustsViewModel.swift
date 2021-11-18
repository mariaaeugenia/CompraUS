import Foundation

protocol AdjustPresentable: AnyObject {
    func deleteRow(at index: Int)
    func reloadTableView()
}

class AdjustsViewModel: ViewModel {
    
    let stateRepository = StateReposioty()
    var states = [State]()
    
    var statesNumberOfRows: Int {
        get { return states.count }
    }
    
    weak var presenter: AdjustPresentable?
    
    required init() {
        getStates()
    }
    
    //MARK: -
    //MARK: - REQUEST
    private func getStates() {
        stateRepository.fetch { [weak self] result in
            self?.states = result
            self?.presenter?.reloadTableView()
        }
    }
    
    func saveState(state: String, tax: String) {
        let stateObj = State()
        stateObj.name = state
        stateObj.tax = tax.getDoubleValue()
        stateRepository.save(object: stateObj)
        getStates()
    }
    
    func deleteState(at index: Int) {
        let state = states[index]
        states.remove(at: index)
        presenter?.deleteRow(at: index)
        
        let prodRepo = ProductRepository()
        if let prodsToDelete = prodRepo.query(name: state.name) {
            for prod in prodsToDelete {
                prodRepo.delete(object: prod)
            }
        }
        stateRepository.delete(object: state)
    
    }
    
    //MARK: -
    //MARK: - TABLE VIEW
    func getState(at index: Int) -> State {
        let state = states[index]
        return state
    }
}
