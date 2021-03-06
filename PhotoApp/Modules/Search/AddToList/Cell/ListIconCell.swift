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

final class ListIconCell: UICollectionViewCell {

    @IBOutlet private weak var backView: UIView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var label: UILabel!
    
    var delegate: ListIconCellDelegate?
    var index = 0
    var cornerRadius = 0.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let iconTap = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        iconTap.cancelsTouchesInView = false
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(iconTap)
    }
    
    func configure(oshiCollection: OshiCollection) {
        imageView.layer.cornerRadius = cornerRadius
        label.text = oshiCollection.listName

        if let firstItem = oshiCollection.items.first {
            guard let url = URL(string: firstItem.url) else { return }
            Nuke.loadImage(with: url, into: imageView)
        } else {
            Nuke.loadImage(with: Config.defaultListIconImageUrl, into: imageView)
        }

    }
    
    @objc private func imageViewTapped() {
        delegate?.imageViewTapped(index: index)
    }

}
