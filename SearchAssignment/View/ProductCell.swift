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
        Bundle.main.loadNibNamed("ProductCell", owner: self, options: nil)
    
        productCellView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(productCellView)
        
        productCellView.frame = self.frame
        
        productCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        productCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        productCellView.topAnchor.constraint(equalTo: self.topAnchor)
        productCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        
    }
}
