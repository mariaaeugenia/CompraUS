//
//  StateTableViewCell.swift
//  CompraUSA
//
//  Created by Maria Eugênia Pereira Teixeira on 21/03/20.
//  Copyright © 2020 Maria Eugênia Pereira Teixeira. All rights reserved.
//

import UIKit

class StateTableViewCell: TableViewCell {
    
    private var stackView: UIStackView!
    private var stateLabel: UILabel!
    private var taxLabel: UILabel!

    //MARK: -
    //MARK: - VIEW LIFE CYCLE
    override func prepareForReuse() {
        super.prepareForReuse()
        stateLabel.text = nil
        taxLabel.text = nil
    }
    
    override func prepareViews() {
        stackView = .init()
        stateLabel = .init()
        taxLabel = .init()
    }
    
    override func addViewHierarchy() {
        stackView.addArrangedSubviews([
            stateLabel,
            taxLabel
        ])
        self.contentView.addSubviews([
            stackView
        ])
    }
    
    override func setupConstraints() {
        taxLabel.snp.makeConstraints { make in
            make.width.equalTo(50)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(16)
            make.right.bottom.equalToSuperview().inset(16)
        }
    }
    
    override func configureViews() {
        selectionStyle = .none
        
        taxLabel.textColor = .red
        taxLabel.textAlignment = .right
        
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
    }
    
    func configureCell(state: State) {
        stateLabel.text = state.name
        taxLabel.text = "\(state.tax)"
    }
    
}
