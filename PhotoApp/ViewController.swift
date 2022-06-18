//
//  ViewController.swift
//  PhotoApp
//
//  Created by Arai Kousuke on 2022/06/14.
//

import UIKit

final class ViewController: UIViewController {
    
    
    @IBOutlet weak var searchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

        let task = URLSession.shared.dataTask(with: urlComponents.url!) { data, response, error in
            guard let jsonData = data else {
                print(error as Any)
                return
            }

            do {
                let result = try JSONDecoder().decode(CustomSearchedResult.self, from: jsonData)
                print(result.items[0])

                
            } catch(let e) {
                print(e)
            }
        }
        task.resume()
    }


}

