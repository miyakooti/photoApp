//
//  ViewController.swift
//  PhotoApp
//
//  Created by Arai Kousuke on 2022/06/14.
//

import UIKit
import Alamofire
import SwiftUI

final class SearchViewController: UIViewController {
    
    @IBOutlet private weak var searchButton: UIButton!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var howToUseLabel: UILabel!
    @IBOutlet private weak var searchTextField: UITextField!
    
    private var searchResult: CustomSearchedResult?
    private let shadeView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        collectionView.register(UINib(nibName: ImageCell.className, bundle: nil), forCellWithReuseIdentifier: ImageCell.className)
        searchButton.addTarget(nil, action: #selector(fetchSearchResult), for: .touchUpInside)
        
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
    
    @objc
    private func fetchSearchResult() {
        guard searchTextField.text != "", let query = searchTextField.text else { return }
        var urlComponents = URLComponents(string: "https://www.googleapis.com/customsearch/v1")!
        urlComponents.queryItems = [
            URLQueryItem(name: "searchType", value: "image"),
            URLQueryItem(name: "q", value: query),
            // To get `key`, create your own project from https://console.developers.google.com/projectcreate
            URLQueryItem(name: "key", value: Config.apiKey),
            // To get `cx`, create your own search engine from https://cse.google.com/cse/create/new
            URLQueryItem(name: "cx", value: Config.searchKey)
        ]

        let task = URLSession.shared.dataTask(with: urlComponents.url!) { [weak self] data, response, error in
            guard let jsonData = data else {
                print(error as Any)
                return
            }

            do {
                let result = try JSONDecoder().decode(CustomSearchedResult.self, from: jsonData)
                self?.searchResult = result
                DispatchQueue.main.async { [weak self] in
                    self?.collectionView.reloadData()
                    self?.searchTextField.endEditing(true)
                }

            } catch(let error) {
                print(error)
            }
        }
        task.resume()
        
    }
    
    private func setUpViews() {
        UITabBar.appearance().tintColor = UIColor.init(hex: "7CC7E8")
        collectionView.delegate = self
        collectionView.dataSource = self
        searchTextField.delegate = self
        
        // レイアウト設定
        let layout = UICollectionViewFlowLayout()
        let width = (UIScreen.main.bounds.width / 2) - 5
        layout.itemSize = CGSize(width: width, height: width + 5)
        layout.minimumLineSpacing = 0
        collectionView.collectionViewLayout = layout
    }

}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.className, for: indexPath) as! ImageCell
        cell.delegate = self
        cell.index = indexPath.row
        if !Config.isDebug {
            if let searchResult = searchResult {
                howToUseLabel.isHidden = true
                cell.loadImage(urlString: searchResult.items[indexPath.row].link)
            } else {
                howToUseLabel.isHidden = false
            }
        }

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

extension SearchViewController: imageCellDelegate {
    
    func bookmarkButtonPressed(index: Int) {
        let vc = AddToListViewController.instantiate()
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

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        fetchSearchResult()
        return true
    }
    
}
