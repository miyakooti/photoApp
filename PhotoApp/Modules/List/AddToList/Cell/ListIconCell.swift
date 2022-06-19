//
//  CollectionCell.swift
//  PhotoApp
//
//  Created by Arai Kousuke on 2022/06/18.
//

import UIKit
import Nuke

protocol ListIconCellDelegate {
    func imageViewTapped(index: Int)
}

class ListIconCell: UICollectionViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    var delegate: ListIconCellDelegate?
    var index = 0
    var cornerRadius = 0.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.clipsToBounds = true
        
        let iconTap = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        iconTap.cancelsTouchesInView = false
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(iconTap)
    }
    
    func configure(oshiCollection: OshiCollection) {
        imageView.layer.cornerRadius = cornerRadius
        label.text = oshiCollection.listName

        if let firstItem = oshiCollection.items.first {
            guard let url = URL(string: firstItem.url) else { return }
            Nuke.loadImage(with: url, into: imageView)
        }

    }
    
    @objc func imageViewTapped() {
        delegate?.imageViewTapped(index: index)
    }

}
