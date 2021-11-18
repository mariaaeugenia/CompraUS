
import UIKit

protocol ViewSetup: class {
    func setup()
    func prepareViews()
    func addViewHierarchy()
    func setupConstraints()
    func configureViews()
}

extension ViewSetup {
    func setup() {
        prepareViews()
        addViewHierarchy()
        setupConstraints()
        configureViews()
    }
}
