
import UIKit

class ViewController<T: ViewModel>: UIViewController, ViewSetup {
    
    var vm: T
    
    convenience init(_ viewModel: T) {
        self.init()
        vm = viewModel
    }

    required public init() {
        vm = .init()
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        vm = .init()
        super.init(coder: aDecoder)
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    func prepareViews() {}
    func addViewHierarchy() {}
    func setupConstraints() {}
    func configureViews() {}
}
