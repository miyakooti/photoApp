//
//  AddToListViewController.swift
//  PhotoApp
//
//  Created by Arai Kousuke on 2022/06/18.
//

import UIKit
import SVProgressHUD

class AddToListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var backView: UIView!
    
    var oshiCollections: [OshiCollection]?
    var pushedUrl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib(nibName: ListIconCell.className, bundle: nil), forCellWithReuseIdentifier: ListIconCell.className)
        collectionView.register(UINib(nibName: AddButtonCell.className, bundle: nil), forCellWithReuseIdentifier: AddButtonCell.className)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        cancelButton.addTarget(nil, action: #selector(cancelButtonPressed), for: .touchUpInside)
        
        backView.layer.cornerRadius = 15
        backView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
//        bring test data
//        oshiCollection = Config.testData
//        JsonEncoder.saveItemsToUserDefaults(list: testData, key: "oshiCollection")
        oshiCollections = JsonEncoder.readItemsFromUserUserDefault(key: .oshiCollectionKey)
                
        // レイアウト設定
        let layout = UICollectionViewFlowLayout()
        let width = 90
        layout.itemSize = CGSize(width: width, height: 110)
        collectionView.collectionViewLayout = layout
                
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    @objc
    private func cancelButtonPressed() {
        self.dismiss(animated: true, completion: nil)
        NotificationCenter.default.post(name: .shouldCloseShade, object: nil)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
            if let text = textField.text, text.count > 10 {
                textField.text = String(text.prefix(10))
            }
        }
    
}

extension AddToListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddButtonCell.className, for: indexPath) as! AddButtonCell
            cell.delegate = self
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListIconCell.className, for: indexPath) as! ListIconCell
            cell.delegate = self
            cell.cornerRadius = (90.0 - 5 * 2) / 2
            if let oshiCollections = oshiCollections, oshiCollections.count > 0 {
                cell.index = indexPath.row - 1
                cell.configure(oshiCollection: oshiCollections[indexPath.row - 1])
            }
            return cell
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let oshiCollections = oshiCollections else { return 0 }
        return oshiCollections.count + 1
    }
    
}

extension AddToListViewController: addButtonCellDelegate {
    func plusButtonTapped() {
        let alert: UIAlertController = UIAlertController(title: "新規追加", message: "推しフォルダの名前を入力してください", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.textFields?.first?.placeholder = "推しフォルダ1"
        alert.textFields?.first?.addTarget(self, action: #selector(textFieldDidChange), for: .allEditingEvents)
        let saveAction: UIAlertAction = UIAlertAction(title: "決定", style: .default, handler: { [weak self] (_: UIAlertAction!) -> Void in
            guard let text = alert.textFields?.first?.text, !text.isEmpty else { return }
            self?.oshiCollections?.insert(OshiCollection(listName: text, items: []), at: 0)
            guard let oshiCollections = self?.oshiCollections else { return }
            JsonEncoder.saveItemsToUserDefaults(list: oshiCollections, key: .oshiCollectionKey)
            SVProgressHUD.showSuccess(withStatus: "推しフォルダを追加しました")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                SVProgressHUD.dismiss()
            }
            self?.collectionView.reloadData()
            
        })
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
        
    }
    
    
}

extension AddToListViewController: ListIconCellDelegate {
    func imageViewTapped(index: Int) {
        // リストに保存する処理
        guard var oshiCollections = oshiCollections,
              pushedUrl != "" else { return }
        oshiCollections[index].items.insert(ListItem(url: pushedUrl), at: 0)
        JsonEncoder.saveItemsToUserDefaults(list: oshiCollections, key: .oshiCollectionKey)
        
        self.dismiss(animated: true, completion: nil)
        NotificationCenter.default.post(name: .shouldCloseShade, object: nil)
        
        SVProgressHUD.showSuccess(withStatus: "推しを保存しました")

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            SVProgressHUD.dismiss()
        }

        
    }
}
