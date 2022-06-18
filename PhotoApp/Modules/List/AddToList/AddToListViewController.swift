//
//  AddToListViewController.swift
//  PhotoApp
//
//  Created by Arai Kousuke on 2022/06/18.
//

import UIKit

class AddToListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var cancelButton: UIButton!
    
    var imageCollection: [ImageCollection]?
    @IBOutlet weak var backView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cancelButton.addTarget(nil, action: #selector(cancelButtonPressed), for: .touchUpInside)

        collectionView.register(UINib(nibName: "CollectionCell", bundle: nil), forCellWithReuseIdentifier: "CollectionCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        backView.layer.cornerRadius = 15
        backView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        let testData = [
            ImageCollection(listName: "齊藤京子", items: [ListItem(url: "https://cdn.hinatazaka46.com/images/14/691/64f4b4d860bc36d8d436cc4d4d2db/1000_1000_102400.jpg")]),
            ImageCollection(listName: "齊藤京子", items: [ListItem(url: "https://cdn.hinatazaka46.com/images/14/691/64f4b4d860bc36d8d436cc4d4d2db/1000_1000_102400.jpg")]),
            ImageCollection(listName: "齊藤京子", items: [ListItem(url: "https://cdn.hinatazaka46.com/images/14/691/64f4b4d860bc36d8d436cc4d4d2db/1000_1000_102400.jpg")]),
            ImageCollection(listName: "齊藤京子", items: [ListItem(url: "https://cdn.hinatazaka46.com/images/14/691/64f4b4d860bc36d8d436cc4d4d2db/1000_1000_102400.jpg")]),
            ImageCollection(listName: "齊藤京子", items: [ListItem(url: "https://cdn.hinatazaka46.com/images/14/691/64f4b4d860bc36d8d436cc4d4d2db/1000_1000_102400.jpg")]),
            ImageCollection(listName: "齊藤京子", items: [ListItem(url: "https://cdn.hinatazaka46.com/images/14/691/64f4b4d860bc36d8d436cc4d4d2db/1000_1000_102400.jpg")]),
            ImageCollection(listName: "齊藤京子", items: [ListItem(url: "https://cdn.hinatazaka46.com/images/14/691/64f4b4d860bc36d8d436cc4d4d2db/1000_1000_102400.jpg")]),
            ImageCollection(listName: "齊藤京子", items: [ListItem(url: "https://cdn.hinatazaka46.com/images/14/691/64f4b4d860bc36d8d436cc4d4d2db/1000_1000_102400.jpg")]),
            ImageCollection(listName: "齊藤京子", items: [ListItem(url: "https://cdn.hinatazaka46.com/images/14/691/64f4b4d860bc36d8d436cc4d4d2db/1000_1000_102400.jpg")]),
            ImageCollection(listName: "齊藤京子", items: [ListItem(url: "https://cdn.hinatazaka46.com/images/14/691/64f4b4d860bc36d8d436cc4d4d2db/1000_1000_102400.jpg")]),
            ImageCollection(listName: "齊藤京子", items: [ListItem(url: "https://cdn.hinatazaka46.com/images/14/691/64f4b4d860bc36d8d436cc4d4d2db/1000_1000_102400.jpg")])

        ]
        
        // レイアウト設定
        let layout = UICollectionViewFlowLayout()
        let width = (collectionView.frame.width / 3) - 30
        layout.itemSize = CGSize(width: width, height: width)
        collectionView.collectionViewLayout = layout
        
        imageCollection = testData
        
        collectionView.reloadData()
        
    }
    
    @objc
    private func cancelButtonPressed() {
        self.dismiss(animated: true, completion: nil)
        NotificationCenter.default.post(name: .shouldCloseShade, object: nil)
    }
    



}

extension AddToListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionCell
        cell.width = Int((collectionView.frame.width / 3) - 30)
        if let imageCollection = imageCollection, imageCollection.count > 0 {
            cell.configure(imageCollection: imageCollection[indexPath.row])
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // リスト追加する時は＋1すればいい
        guard let imageCollection = imageCollection else { return 0 }
        return imageCollection.count
    }
    
    
}


extension Notification.Name {
    static let shouldCloseShade = Notification.Name("shouldCloseShade")
}
