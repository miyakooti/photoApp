//
//  ImageCell.swift
//  PhotoApp
//
//  Created by Arai Kousuke on 2022/06/18.
//

import UIKit
import Nuke

protocol imageCellDelegate {
    func bookmarkButtonPressed(index: Int)
}

class ImageCell: UICollectionViewCell {
    @IBOutlet weak var backVIew: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var bookmarkButton: UIButton!

    var index = 0
    var delegate: imageCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bookmarkButton.addTarget(nil, action: #selector(bookmarkButtonPressed), for: .touchUpInside)
    }
    
    func loadImage(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        Nuke.loadImage(with: url, into: imageView)
    }
    
    @objc func bookmarkButtonPressed() {
        delegate?.bookmarkButtonPressed(index: index)
    }

}
