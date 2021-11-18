import UIKit

class ShoppingTableViewController: TableViewController<ShoppingViewModel> {
    
    private var emptyStateLabel: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        vm.viewModelLoad()
    }
    
    override func prepareViews() {
        emptyStateLabel = .init()
    }
    
    override func configureViews() {
        vm.presenter = self
        configureNavigation()
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped(_:)))
        self.navigationItem.rightBarButtonItem = addButton
        configureTableView()
        configureLabel()
    }
    
    func configureNavigation() {
        self.navigationItem.title = "Lista de Compras"
    }
    
    func configureTableView() {
        tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: "CELL")
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 110
    }
    
    func configureLabel() {
        emptyStateLabel.text = "Sua lista está vazia!"
        emptyStateLabel.textColor = .black
        emptyStateLabel.textAlignment = .center
    }

    @objc func addButtonTapped(_ sender: UIBarButtonItem) {
        self.navigationController?.pushViewController(NewProductViewController(), animated: true)
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if vm.productsNumberOfRows == 0 {
            tableView.backgroundView = emptyStateLabel
            return 0
        }
        tableView.backgroundView = nil
        return vm.productsNumberOfRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath) as? ProductTableViewCell else { return UITableViewCell() }
        let prod = vm.getProduct(at: indexPath.row)
        cell.consigureCell(prod: prod)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let prod = vm.didSelect(at: indexPath.row)
        
        let newProdVC = NewProductViewController()
        newProdVC.vm.editProduct = prod
        navigationController?.pushViewController(newProdVC, animated: true)
    }

}

extension ShoppingTableViewController: ProductPresentable {
    
    func relodTableView() {
        tableView.reloadData()
    }
}
