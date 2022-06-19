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
        collectionView.register(UINib(nibName: "AddButtonCell", bundle: nil), forCellWithReuseIdentifier: "AddButtonCell")

        collectionView.delegate = self
        collectionView.dataSource = self
        
        backView.layer.cornerRadius = 15
        backView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        let testData = [
            ImageCollection(listName: "影山優香", items: [ListItem(url: "https://cdn.hinatazaka46.com/images/14/844/02450174314bb3f596ce3254d0fb3/400_320_102400.jpg")]),
            ImageCollection(listName: "齊藤京子2", items: [ListItem(url: "https://cdn.hinatazaka46.com/images/14/691/64f4b4d860bc36d8d436cc4d4d2db/1000_1000_102400.jpg")]),
            ImageCollection(listName: "影山優香", items: [ListItem(url: "https://cdn.hinatazaka46.com/images/14/844/02450174314bb3f596ce3254d0fb3/400_320_102400.jpg")]),
            ImageCollection(listName: "加藤志穂", items: [ListItem(url: "https://cdn.hinatazaka46.com/images/14/730/13682c011735c92c06afa89fea784/400_320_102400.jpg")]),
            ImageCollection(listName: "齊藤京子5", items: [ListItem(url: "https://cdn.hinatazaka46.com/images/14/691/64f4b4d860bc36d8d436cc4d4d2db/1000_1000_102400.jpg")]),
            ImageCollection(listName: "齊藤京子6", items: []),
            ImageCollection(listName: "齊藤京子7", items: [ListItem(url: "https://cdn.hinatazaka46.com/images/14/691/64f4b4d860bc36d8d436cc4d4d2db/1000_1000_102400.jpg")]),
            ImageCollection(listName: "齊藤京子8", items: [ListItem(url: "https://cdn.hinatazaka46.com/images/14/691/64f4b4d860bc36d8d436cc4d4d2db/1000_1000_102400.jpg")]),
            ImageCollection(listName: "齊藤京子9", items: [ListItem(url: "https://cdn.hinatazaka46.com/images/14/691/64f4b4d860bc36d8d436cc4d4d2db/1000_1000_102400.jpg")]),
            ImageCollection(listName: "齊藤京子10", items: [ListItem(url: "https://cdn.hinatazaka46.com/images/14/691/64f4b4d860bc36d8d436cc4d4d2db/1000_1000_102400.jpg")]),

        ]
        
        JsonEncoder.saveItemsToUserDefaults(list: testData, key: "imageCollection")
        
        imageCollection = JsonEncoder.readItemsFromUserUserDefault(key: "imageCollection")
        
        
        
        // レイアウト設定
        let layout = UICollectionViewFlowLayout()
        let width = 90
        layout.itemSize = CGSize(width: width, height: 110)
        collectionView.collectionViewLayout = layout
        
//        imageCollection = testData
        
        collectionView.reloadData()
        
    }
    
    @objc
    private func cancelButtonPressed() {
        self.dismiss(animated: true, completion: nil)
        NotificationCenter.default.post(name: .shouldCloseShade, object: nil)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
            if let text = textField.text, text.count > 5 {
                textField.text = String(text.prefix(5))
            }
        }
    



}

extension AddToListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddButtonCell", for: indexPath) as! AddButtonCell
            cell.delegate = self
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionCell
            if let imageCollection = imageCollection, imageCollection.count > 0 {
                cell.configure(imageCollection: imageCollection[indexPath.row - 1])
            }
            return cell
        }
        

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // リスト追加する時は＋1すればいい
        guard let imageCollection = imageCollection else { return 0 }
        return imageCollection.count + 1
    }
    
    
}

extension AddToListViewController: addButtonCellDelegate {
    func plusButtonTapped() {
        print("ここでアラートの処理")
        
        let alert: UIAlertController = UIAlertController(title: "新規リスト", message: "リストの名前を入力してください", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.textFields?.first?.placeholder = "リスト1"
        alert.textFields?.first?.addTarget(self, action: #selector(textFieldDidChange), for: .allEditingEvents)
        let saveAction: UIAlertAction = UIAlertAction(title: "決定", style: .default, handler: { [weak self] (_: UIAlertAction!) -> Void in
            guard let text = alert.textFields?.first?.text, !text.isEmpty else { return }
            self?.imageCollection?.append(ImageCollection(listName: text, items: []))
            self?.collectionView.reloadData()
            
        })
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
        
    }
    
    
}


extension Notification.Name {
    static let shouldCloseShade = Notification.Name("shouldCloseShade")
}
