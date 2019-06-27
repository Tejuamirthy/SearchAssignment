//
//  ProductCell.swift
//  SearchAssignment
//
//  Created by Amirthy Tejeshwar on 26/06/19.
//  Copyright © 2019 coviam. All rights reserved.
//

import UIKit

class ProductCell: UICollectionViewCell {
    
    @IBOutlet var productCellView: UIView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func commonInit() {
        /// loading the nib file
        Bundle.main.loadNibNamed("ProductCell", owner: self, options: nil)
        /// disabling the autoresizing constraints to change the arrangement
        productCellView.translatesAutoresizingMaskIntoConstraints = false
        /// adding the View we created as a subView to the cell object
        addSubview(productCellView)
        /// setting the constraints of the above view with respect to the Collection View Cell
        productCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        productCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        productCellView.topAnchor.constraint(equalTo: self.topAnchor)
        productCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
    }
}
