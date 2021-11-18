//
//  ProductTableViewCell.swift
//  ComprasUSA
//
//  Created by Maria Eugênia Pereira Teixeira on 21/03/20.
//  Copyright © 2020 Maria Eugênia Pereira Teixeira. All rights reserved.
//

import UIKit

class ProductTableViewCell: TableViewCell {
    
    private var productImage: UIImageView!
    private var stackView: UIStackView!
    private var productName: UILabel!
    private var productValue: UILabel!

    //MARK: -
    //MARK: - VIEW LIFE CYCLE
    override func prepareForReuse() {
        super.prepareForReuse()
        productImage.image = nil
        productName.text = nil
        productValue.text = nil
    }
    
    override func prepareViews() {
        productImage = .init()
        stackView = .init()
        productName = .init()
        productValue = .init()
    }
    
    override func addViewHierarchy() {
        stackView.addArrangedSubviews([
            productName,
            productValue
        ])
        contentView.addSubviews([
            productImage,
            stackView
        ])
    }
    
    override func setupConstraints() {
        
        productImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.width.height.equalTo(80)
        }
        
        stackView.snp.makeConstraints { make in
            make.left.equalTo(productImage.snp.right).offset(16)
            make.centerY.equalTo(productImage.snp.centerY)
            make.right.equalToSuperview().inset(16)
        }
    }
    
    override func configureViews() {
        selectionStyle = .none
        
        productImage.layer.cornerRadius = 10
        productImage.contentMode = .scaleAspectFit
        
        productName.numberOfLines = 2
        productValue.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
    }
    
    func consigureCell(prod: Product) {
        if let data = prod.image {
            productImage.image = UIImage(data: data)
        } else {
            productImage.image = UIImage(named: "placeholder")
        }
        productName.text = prod.name
        productValue.text = prod.value.getDollarCurrency()
    }
    
}
