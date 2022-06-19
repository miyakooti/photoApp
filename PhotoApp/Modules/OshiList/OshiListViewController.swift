//
//  OshiListViewController.swift
//  PhotoApp
//
//  Created by Arai Kousuke on 2022/06/19.
//

import UIKit

class OshiListViewController: UIViewController {


    @IBOutlet weak var backImage: UIImageView!
    
    var oshiCollection: OshiCollection?
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: "ImageCell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // レイアウト設定
        let layout = UICollectionViewFlowLayout()
        let width = (UIScreen.main.bounds.width / 2) - 5
        layout.itemSize = CGSize(width: width, height: width + 5)
        layout.minimumLineSpacing = 0
        collectionView.collectionViewLayout = layout
        
        let iconTap = UITapGestureRecognizer(target: self, action: #selector(backImageTapped))
        iconTap.cancelsTouchesInView = false
        backImage.isUserInteractionEnabled = true
        backImage.addGestureRecognizer(iconTap)
        print(oshiCollection?.items.count)
        titleLabel.text = oshiCollection?.listName
    }
    
    @objc func backImageTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    


}

extension OshiListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        cell.delegate = self
        cell.index = indexPath.row
        cell.isViewMode = true
        if !Config.isDebug {
            if let oshiCollection = oshiCollection {
                cell.loadImage(urlString:
                                oshiCollection.items[indexPath.row].url)
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
