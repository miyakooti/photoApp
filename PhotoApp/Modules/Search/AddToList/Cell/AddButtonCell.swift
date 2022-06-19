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

final class AddButtonCell: UICollectionViewCell {
    
    @IBOutlet private weak var plusImage: UIImageView!

    var delegate: addButtonCellDelegate?

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
