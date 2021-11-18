import UIKit

class AdjustsViewController: ViewController<AdjustsViewModel> {

    //MARK: -
    //MARK: - OUTLETS
    private var dollarStackView: UIStackView!
    private var dollarLabel: UILabel!
    private var dollarValueTextField: TextField!
    private var iofStackView: UIStackView!
    private var iofLabel: UILabel!
    private var iofTextField: TextField!
    private var dolarIofStackView: UIStackView!
    private var titleLabel: UILabel!
    private var tableView: UITableView!
    private var addStateButton: UIButton!
    
    private var stateTextField: UITextField!
    private var taxTextField: UITextField!
    
    //MARK: -
    //MARK: - VIEW CODE LIFE CYCLE
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let dollar = dollarValueTextField.text, !dollar.isEmpty {
            Constants.Settings.updateDollarCurrency(with: dollar)
        }
        if let iof = iofTextField.text, !iof.isEmpty {
            Constants.Settings.updateIOF(with: iof)
        }
    }
    override func prepareViews() {
        dollarStackView = .init()
        dollarValueTextField = .init()
        dollarLabel = .init()
        iofStackView = .init()
        iofTextField = .init()
        iofLabel = .init()
        dolarIofStackView = .init()
        titleLabel = .init()
        tableView = .init()
        addStateButton = .init()
    }
    
    override func addViewHierarchy() {
        dollarStackView.addArrangedSubviews([
            dollarLabel,
            dollarValueTextField
        ])
        
        iofStackView.addArrangedSubviews([
            iofLabel,
            iofTextField
        ])
        
        dolarIofStackView.addArrangedSubviews([
            dollarStackView,
            iofStackView
        ])
        
        view.addSubviews([
            dolarIofStackView,
            titleLabel,
            tableView,
            addStateButton
        ])
    }
    
    override func setupConstraints() {
        
        dollarValueTextField.snp.makeConstraints { make in
            make.width.equalTo(view.frame.width*0.3)
            make.height.equalTo(40)
        }
        
        iofTextField.snp.makeConstraints { make in
            make.width.equalTo(view.frame.width*0.3)
            make.height.equalTo(40)
        }
    
        dolarIofStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(UIWindow.getSafeAreaInsets().top + 20)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(dolarIofStackView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(addStateButton.snp.top).offset(16)
        }
        
        addStateButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(UIWindow.getSafeAreaInsets().bottom + 60)
            make.right.equalToSuperview().inset(16)
            make.height.equalTo(35)
        }
    }
    
    override func configureViews() {
        view.backgroundColor = .white
        vm.presenter = self
        configureDolarViews()
        configureIOFViews()
        configureStackView()
        configureTitleLabel()
        confirgureTableView()
        configureAddStateButton()
    }
    
    private func configureDolarViews() {
        dollarLabel.text = "Cotação do dólar (R$):"
        dollarLabel.textAlignment = .right
        
        dollarValueTextField.text = Constants.Settings.dollarCurrency
        dollarValueTextField.textAlignment = .right
        dollarValueTextField.keyboardType = .decimalPad
    }
    
    private func configureIOFViews() {
        iofLabel.text = "IOF (%):"
        iofLabel.textAlignment = .right
        
        iofTextField.text = Constants.Settings.iof
        iofTextField.textAlignment = .right
        iofTextField.keyboardType = .decimalPad
    }
    
    private func configureStackView() {
        dollarStackView.alignment = .center
        dollarStackView.distribution = .fill
        dollarStackView.axis = .horizontal
        dollarStackView.spacing = 10
        
        iofStackView.alignment = .center
        iofStackView.distribution = .fill
        iofStackView.axis = .horizontal
        iofStackView.spacing = 10
        
        dolarIofStackView.axis = .vertical
        dolarIofStackView.alignment = .fill
        dolarIofStackView.distribution = .fillEqually
        dolarIofStackView.spacing = 20
    }
    
    private func configureTitleLabel() {
        titleLabel.text = "Impostos por estado"
        titleLabel.font = UIFont.systemFont(ofSize: 16.0, weight: .bold)
        titleLabel.textColor = .black
    }
    
    private func confirgureTableView() {
        tableView.register(StateTableViewCell.self, forCellReuseIdentifier: "CELL")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 50
        tableView.tableFooterView = UIView()
    }
    
    private func configureAddStateButton() {
        addStateButton.setTitle("Adicionar estado", for: .normal)
        addStateButton.setTitleColor(.link, for: .normal)
        addStateButton.addTarget(self, action: #selector(addStateButtonTapped(_ :)), for: .touchUpInside)
    }
    
    //MARK: -
    //MARK: - BUTTON ACTIONS
    @objc func addStateButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Adicionar estado", message: "", preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "Nome do estado"
            self.stateTextField = textField
        }
        
        alert.addTextField { textField in
            textField.placeholder = "Imposto"
            textField.keyboardType = .decimalPad
            self.taxTextField = textField
        }
        
        alert.addAction(UIAlertAction(title: "Adicionar", style: .default, handler: { [weak self] _ in
            self?.saveState()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: -
    //MARK: - SAVE STATE
    func saveState() {
        if let state = stateTextField.text, !state.isEmpty,
            let tax = taxTextField.text, !tax.isEmpty {
            vm.saveState(state: state, tax: tax)
        }
    }

}

extension AdjustsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.statesNumberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath) as? StateTableViewCell else { return UITableViewCell() }
        let state = vm.getState(at: indexPath.row)
        cell.configureCell(state: state)
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let modifyAction = UIContextualAction(style: .normal, title: "Deletar", handler: { [weak self] (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            self?.vm.deleteState(at: indexPath.row)
            success(true)
        })
        modifyAction.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [modifyAction])
    }
}

extension AdjustsViewController: AdjustPresentable {
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func deleteRow(at index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
}
