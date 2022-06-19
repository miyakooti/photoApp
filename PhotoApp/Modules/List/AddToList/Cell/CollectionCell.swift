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
    @IBOutlet weak var label: UILabel!
    
    var width = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.clipsToBounds = true
    }
    
    func configure(imageCollection: ImageCollection) {
        imageView.layer.cornerRadius = CGFloat((90 - 5 * 2) / 2)
        label.text = imageCollection.listName

        if let firstItem = imageCollection.items.first {
            guard let url = URL(string: firstItem.url) else { return }
            Nuke.loadImage(with: url, into: imageView)
        }

    }

}
