//
//  ProductCollectionViewCell.swift
//  SearchAssignment
//
//  Created by Amirthy Tejeshwar on 22/06/19.
//  Copyright © 2019 coviam. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var productNameLabel: UILabel!
    
    @IBOutlet weak var productPrice: UILabel!
  
    override init(frame: CGRect) {
        super.init(frame: frame)
//        setConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        setConstraints()
        
    }
   
    override func prepareForReuse() {
        //self.updateConstraintsIfNeeded()
        super.prepareForReuse()
        //setConstraints()
    }
    
    func setConstraints() {
        productImage.translatesAutoresizingMaskIntoConstraints = false
        productPrice.translatesAutoresizingMaskIntoConstraints = false
        productNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        productImage.leadingAnchor.constraint(equalTo: self.leadingAnchor , constant: 10).isActive = true
        productImage.trailingAnchor.constraint(equalTo: self.trailingAnchor , constant: -10).isActive = true
        productImage.topAnchor.constraint(equalTo: self.topAnchor , constant: 10).isActive = true
        //productImage.bottomAnchor.constraint(equalTo: productNameLabel.topAnchor , constant: -20).isActive = true
        
        
        productPrice.leadingAnchor.constraint(equalTo: self.leadingAnchor , constant: 10).isActive = true
        productPrice.trailingAnchor.constraint(equalTo: self.trailingAnchor , constant: -10).isActive = true
        productPrice.bottomAnchor.constraint(equalTo: self.bottomAnchor , constant: -10).isActive = true
        productPrice.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor , constant: 0).isActive = true
        
        
        productNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor , constant: 10).isActive = true
        productNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor , constant: -10).isActive = true
        productNameLabel.bottomAnchor.constraint(equalTo: productPrice.topAnchor , constant: 0).isActive = true
        productNameLabel.topAnchor.constraint(equalTo: productImage.bottomAnchor , constant: 20).isActive = true
    }
    
}
