//
//  OshiCollectionViewController.swift
//  PhotoApp
//
//  Created by Arai Kousuke on 2022/06/19.
//

import UIKit

class OshiCollectionViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var oshiCollections: [OshiCollection]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        
        
        collectionView.register(UINib(nibName: ListIconCell.className, bundle: nil), forCellWithReuseIdentifier: ListIconCell.className)

        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // レイアウト設定
        let layout = UICollectionViewFlowLayout()
        let width = 110

        layout.itemSize = CGSize(width: width, height: 134)
        collectionView.collectionViewLayout = layout
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        oshiCollections = JsonEncoder.readItemsFromUserUserDefault(key: .oshiCollectionKey)
        collectionView.reloadData()
    }

}


extension OshiCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListIconCell.className, for: indexPath) as! ListIconCell
        cell.delegate = self
        cell.cornerRadius = 20
        if let oshiCollections = oshiCollections, oshiCollections.count > 0 {
            cell.index = indexPath.row
            cell.configure(oshiCollection: oshiCollections[indexPath.row])
        }
        return cell
        

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let oshiCollections = oshiCollections else { return 0 }
        return oshiCollections.count
    }
    
}

extension OshiCollectionViewController: ListIconCellDelegate {
   
    func imageViewTapped(index: Int) {
        if let oshiCollections = oshiCollections, oshiCollections.count > 0 {
            let oshiCollection = oshiCollections[index]
            let vc = OshiListViewController.loadStoryboard()
            vc.oshiCollection = oshiCollection
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    
}
