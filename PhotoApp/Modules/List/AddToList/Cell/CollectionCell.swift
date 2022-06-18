//
//  CollectionCell.swift
//  PhotoApp
//
//  Created by Arai Kousuke on 2022/06/18.
//

import UIKit
import Nuke

class CollectionCell: UICollectionViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.cornerRadius = min(imageView.bounds.size.height, imageView.bounds.size.width) / 2
    }
    
    func configure(imageCollection: ImageCollection) {
        if let firstItem = imageCollection.items.first {
            guard let url = URL(string: firstItem.url) else { return }
            Nuke.loadImage(with: url, into: imageView)
        }
    }

}
