//
//  TextField.swift
//  CompraUSA
//
//  Created by Maria Eugênia Pereira Teixeira on 19/03/20.
//  Copyright © 2020 Maria Eugênia Pereira Teixeira. All rights reserved.
//

import UIKit

class TextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        borderStyle = .roundedRect
        textColor = .black
    }
}
