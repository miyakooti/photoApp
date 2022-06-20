//
//  OshiListViewController.swift
//  PhotoApp
//
//  Created by Arai Kousuke on 2022/06/19.
//

import UIKit

final class OshiListViewController: UIViewController {
    
    @IBOutlet private weak var backImage: UIImageView!
    
    var oshiCollection: OshiCollection?
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib(nibName: ImageCell.className, bundle: nil), forCellWithReuseIdentifier: ImageCell.className)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        setUpViews()
    }
    
    @objc private func backImageTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setUpViews() {
        // レイアウト設定
        let layout = UICollectionViewFlowLayout()
        let width = (UIScreen.main.bounds.width / 2) - 5
        layout.itemSize = CGSize(width: width, height: width + 5)
        layout.minimumLineSpacing = 0
        collectionView.collectionViewLayout = layout
        
        titleLabel.text = oshiCollection?.listName
        let iconTap = UITapGestureRecognizer(target: self, action: #selector(backImageTapped))
        iconTap.cancelsTouchesInView = false
        backImage.isUserInteractionEnabled = true
        backImage.addGestureRecognizer(iconTap)
    }
    
}

extension OshiListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.className, for: indexPath) as! ImageCell
        cell.delegate = self
        cell.index = indexPath.row
        cell.isViewMode = true
        if !Config.isDebug {
            if let oshiCollection = oshiCollection {
                cell.loadImage(urlString: oshiCollection.items[indexPath.row].url)
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !Config.isDebug {
            guard let oshiCollection = oshiCollection else { return 0 }
            return oshiCollection.items.count
        }
        return 20
    }
    
}

extension OshiListViewController: imageCellDelegate {
    func bookmarkButtonPressed(index: Int) {
        return
    }
}
