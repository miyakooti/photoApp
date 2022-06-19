//
//  ViewController.swift
//  PhotoApp
//
//  Created by Arai Kousuke on 2022/06/14.
//

import UIKit
import Alamofire
import SwiftUI

final class ListViewController: UIViewController {
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var searchResult: CustomSearchedResult?
    @IBOutlet weak var searchTextField: UITextField!
    private let shadeView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: "ImageCell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        searchTextField.delegate = self
        
        // レイアウト設定
        let layout = UICollectionViewFlowLayout()
        let width = (UIScreen.main.bounds.width / 2) - 5
        layout.itemSize = CGSize(width: width, height: width)
        collectionView.collectionViewLayout = layout

        searchButton.addTarget(nil, action: #selector(search), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onShouldCloseShade(_:)), name: .shouldCloseShade, object: nil)

    }
    
    @objc
    private func onShouldCloseShade(_ notification: Notification) {
        UIView.animate(withDuration: 0.2) {
            self.shadeView.alpha = 0
        } completion: { done in
            if done {
                self.shadeView.removeFromSuperview()
            }
        }
    }
    
    @objc private func search() {
        guard searchTextField.text != "", let query = searchTextField.text else { return }
        var urlComponents = URLComponents(string: "https://www.googleapis.com/customsearch/v1")!
        urlComponents.queryItems = [
            URLQueryItem(name: "searchType", value: "image"),
            URLQueryItem(name: "q", value: query),
            // To get `key`, create your own project from https://console.developers.google.com/projectcreate
            URLQueryItem(name: "key", value: "AIzaSyD3l2kihyoZxZTSEI4JP52mv3qCLpMxGZE"),
            // To get `cx`, create your own search engine from https://cse.google.com/cse/create/new
            URLQueryItem(name: "cx", value: "74ba61de5531c3dd3")
        ]
        print(urlComponents.string!)

        let task = URLSession.shared.dataTask(with: urlComponents.url!) { [weak self] data, response, error in
            guard let jsonData = data else {
                print(error as Any)
                return
            }

            do {
                let result = try JSONDecoder().decode(CustomSearchedResult.self, from: jsonData)
                print(result.items[0])
                self?.searchResult = result
                DispatchQueue.main.async { [weak self] in
                    self?.collectionView.reloadData()
                    self?.searchTextField.endEditing(true)
                }

            } catch(let e) {
                print(e)
            }
        }
        task.resume()
        
    }
//    override func didReceiveMemoryWarning() {
//            super.didReceiveMemoryWarning()
//        }
//
//
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.view.endEditing(true)
//    }


}

extension ListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        cell.delegate = self
        cell.index = indexPath.row
        if !Config.isDebug {
            if let searchResult = searchResult {
                cell.loadImage(urlString: searchResult.items[indexPath.row].link)
            }
        }

//        if let searchResult = searchResult {
//            cell.loadImage(urlString: "https://cdn.hinatazaka46.com/images/14/691/64f4b4d860bc36d8d436cc4d4d2db/1000_1000_102400.jpg")
//        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !Config.isDebug {
            guard let searchResult = searchResult else { return 0 }
            return searchResult.items.count
        }

        return 20
    }
    
    
    
    
}

extension ListViewController: imageCellDelegate {
    func bookmarkButtonPressed(index: Int) {
        print("押されたのは", index)
        
        let vc = AddToListViewController.instantiate()
//        vc.delegate = self
        vc.modalPresentationStyle = .overCurrentContext
        if !Config.isDebug {
            guard let link = searchResult?.items[index].link else { return }
            vc.pushedUrl = link
        }
        self.present(vc, animated: true, completion: nil)
        
        shadeView.backgroundColor = .black
        shadeView.alpha = 0
        self.view.addSubview(shadeView)
        UIView.animate(withDuration: 0.2) {
            self.shadeView.alpha = 0.3
        }
    }
    
    
}

extension ListViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        search()
        return true
    }
    
}
