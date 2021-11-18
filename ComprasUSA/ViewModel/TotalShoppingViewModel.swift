import Foundation

protocol TotalShoppingPresentable: AnyObject {
    func presentTotalDolar(total: String)
    func presentTotalReal(total: String)
}

class TotalShoppingViewModel: ViewModel {
    
    let productRepository = ProductRepository()
    
    weak var presenter: TotalShoppingPresentable?
    
    required init() {}
    
    func viewModelLoad() {
        getAllProducts()
    }
    
    private func getAllProducts() {
        productRepository.fetch { [weak self] result in
            self?.getTotalDollar(for: result)
            self?.getTotalReal(for: result)
        }
    }
    
    func getTotalDollar(for products: [Product]) {
        var totalDollar = 0.0
        for prod in products {
            let tax = 1 + (prod.state?.tax ?? 0)/100
            totalDollar = totalDollar + prod.value*tax
        }
        let strDollar = totalDollar.getDollarCurrency().replacingOccurrences(of: "$", with: "")
        presenter?.presentTotalDolar(total: strDollar)
    }
    
    func getTotalReal(for products: [Product]) {
        let dollarCurrency = Constants.Settings.dollarCurrency.getDoubleValue()
        let iof = Constants.Settings.iof.getDoubleValue()
        var totalReal = 0.0
        for prod in products {
            let tax = 1 + (prod.state?.tax ?? 0)/100
            let dollar = prod.value*tax
            let real = dollar*dollarCurrency
            
            if prod.isCreditCard {
                let value = real * (1 + (iof/100))
                totalReal = totalReal + value
            } else {
                 totalReal = totalReal + real
            }
        }
        let strReal = totalReal.getRealCurrency().replacingOccurrences(of: "R$", with: "")
        presenter?.presentTotalReal(total: strReal)
    }
    
}
