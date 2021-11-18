import UIKit

class TotalShoppingViewController: ViewController<TotalShoppingViewModel> {
    
    //MARK: -
    //MARK: - OUTLETS
    private var mainStackView: UIStackView!
    private var totalDollarStackView: UIStackView!
    private var totalDolarTitleLabel: UILabel!
    private var totalDolarLabel: UILabel!
    private var totalRealStackView: UIStackView!
    private var totalRealTitleLabel: UILabel!
    private var totalRealLabel: UILabel!
    
    //MARK: -
    //MARK: - VIEW CODE LIFE CYCLE
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        vm.viewModelLoad()
    }
    
    override func prepareViews() {
        mainStackView = .init()
        totalDollarStackView = .init()
        totalDolarTitleLabel = .init()
        totalDolarLabel = .init()
        totalRealStackView = .init()
        totalRealTitleLabel = .init()
        totalRealLabel = .init()
    }
    
    override func addViewHierarchy() {
        
        totalDollarStackView.addArrangedSubviews([
            totalDolarTitleLabel,
            totalDolarLabel
        ])
        
        totalRealStackView.addArrangedSubviews([
            totalRealTitleLabel,
            totalRealLabel
        ])
        
        mainStackView.addArrangedSubviews([
            totalDollarStackView,
            totalRealStackView
        ])
    
        view.addSubviews([
            mainStackView
        ])
    }
    
    override func setupConstraints() {
        mainStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(UIWindow.getSafeAreaInsets().top + 40)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(view.frame.width*0.7)
        }
    }
    
    override func configureViews() {
        view.backgroundColor = .white
        vm = .init()
        vm.presenter = self
        configureMainStackView()
        configureDollar()
        configureReal()
    }
    
    func configureMainStackView() {
        mainStackView.axis = .vertical
        mainStackView.alignment = .fill
        mainStackView.distribution = .fill
        mainStackView.spacing = 60
    }
    
    func configureDollar() {
        totalDolarTitleLabel.text = "Total em U$:"
         
        totalDolarLabel.text = "0"
        totalDolarLabel.textColor = .red
        totalDolarLabel.font = UIFont.systemFont(ofSize: 50, weight: .bold)
        
        totalDollarStackView.axis = .vertical
        totalDollarStackView.alignment = .center
        totalDollarStackView.distribution = .fillProportionally
        totalDollarStackView.spacing = 5
    }
    
    func configureReal() {
        totalRealTitleLabel.text = "Total em R$:"
        
        totalRealLabel.text = "0"
        totalRealLabel.textColor = .systemGreen
        totalRealLabel.font = UIFont.systemFont(ofSize: 50, weight: .bold)
        
        totalRealStackView.axis = .vertical
        totalRealStackView.alignment = .center
        totalRealStackView.distribution = .fillProportionally
        totalRealStackView.spacing = 5

    }
}

extension TotalShoppingViewController: TotalShoppingPresentable {
    
    func presentTotalDolar(total: String) {
        totalDolarLabel.text = total
    }
    
    func presentTotalReal(total: String) {
        totalRealLabel.text = total
    }
}
