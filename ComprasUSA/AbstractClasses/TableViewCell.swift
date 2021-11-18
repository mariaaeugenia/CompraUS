
import UIKit

open class TableViewCell: UITableViewCell, ViewSetup {
    
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func prepareViews() {}
    open func addViewHierarchy() {}
    open func setupConstraints() {}
    open func configureViews() {}
    open func configureBindings() {}
    
}
