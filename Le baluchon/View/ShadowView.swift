//
//  ShadowView.swift
//  Le baluchon
//
//  Created by Frederick Port on 17/12/2019.
//  Copyright © 2019 Frederick Port. All rights reserved.
//

import UIKit

final class ShadowView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup () {
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowRadius = 3
        alpha = 0.95
        layer.cornerRadius = 10
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowOpacity = 0.75
    }
    
}
