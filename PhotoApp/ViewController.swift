//
//  ViewController.swift
//  PhotoApp
//
//  Created by Arai Kousuke on 2022/06/14.
//

import UIKit
import Alamofire

final class ViewController: UIViewController {
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var searchResult: CustomSearchedResult?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: "ImageCell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // レイアウト設定
        let layout = UICollectionViewFlowLayout()
        let width = (UIScreen.main.bounds.width / 2) - 5
        layout.itemSize = CGSize(width: width, height: width)
        collectionView.collectionViewLayout = layout

        searchButton.addTarget(nil, action: #selector(searchButtonPressed), for: .touchUpInside)
    }
    
    @objc private func searchButtonPressed() {
        let query = "さいとうきょうこ"
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
                }

            } catch(let e) {
                print(e)
            }
        }
        task.resume()
        
    }


}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        if let searchResult = searchResult {
            cell.loadImage(urlString: searchResult.items[indexPath.row].link)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let searchResult = searchResult else { return 0 }
        return searchResult.items.count
    }
    
    
    
    
}
