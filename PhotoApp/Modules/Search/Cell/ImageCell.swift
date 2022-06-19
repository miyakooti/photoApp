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

final class ImageCell: UICollectionViewCell {
    @IBOutlet private weak var backVIew: UIView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var bookmarkButton: UIButton!

    var index = 0
    var delegate: imageCellDelegate?
    var isViewMode = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bookmarkButton.addTarget(nil, action: #selector(bookmarkButtonPressed), for: .touchUpInside)
    }
    
    func loadImage(urlString: String) {
        if isViewMode {
            bookmarkButton.isHidden = true
        }
        guard let url = URL(string: urlString) else { return }
        Nuke.loadImage(with: url, into: imageView)
    }
    
    @objc private func bookmarkButtonPressed() {
        delegate?.bookmarkButtonPressed(index: index)
    }

}
