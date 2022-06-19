//
//  addButtonCell.swift
//  PhotoApp
//
//  Created by Arai Kousuke on 2022/06/18.
//

import UIKit

protocol addButtonCellDelegate {
    func plusButtonTapped()
}

class AddButtonCell: UICollectionViewCell {
    
    var delegate: addButtonCellDelegate?

    @IBOutlet weak var plusImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let plusTap = UITapGestureRecognizer(target: self, action: #selector(plusButtonTapped))
        plusTap.cancelsTouchesInView = false
        plusImage.isUserInteractionEnabled = true
        plusImage.addGestureRecognizer(plusTap)
    }
    
    @objc func plusButtonTapped() {
        delegate?.plusButtonTapped()
        
    }
    

}
