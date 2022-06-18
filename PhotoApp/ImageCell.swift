//
//  ImageCell.swift
//  PhotoApp
//
//  Created by Arai Kousuke on 2022/06/18.
//

import UIKit
import Nuke

class ImageCell: UICollectionViewCell {
    @IBOutlet weak var backVIew: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func loadImage(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        Nuke.loadImage(with: url, into: imageView)
    }

}
