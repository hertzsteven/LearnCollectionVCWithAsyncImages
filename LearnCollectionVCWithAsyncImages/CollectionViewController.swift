//
//  RootViewController.swift
//  LearnCollectionVCWithAsyncImages
//
//  Created by Steven Hertz on 5/31/22.
//

import UIKit

struct PostUserProfileImage: Codable {
  let medium: String
}

struct PostUser: Codable {
  let profile_image: PostUserProfileImage
}

struct PostUrls: Codable {
  let regular: String
}

struct Post: Codable {
  let id: String
  let description: String?
  let user: PostUser
  let urls: PostUrls
}

 struct APIResponse: Codable {
  let results: [Post]?
}

final class CollectionViewController: UIViewController {

    var apiResponse = APIResponse(results: [])
    
    var data = [UIColor.red, UIColor.green, UIColor.blue, UIColor.green, UIColor.purple, UIColor.orange, UIColor.blue, UIColor.green, UIColor.blue, UIColor.green, UIColor.red, UIColor.green, UIColor.blue, UIColor.green, UIColor.purple, UIColor.orange, UIColor.blue, UIColor.green, UIColor.blue, UIColor.green, UIColor.red, UIColor.green, UIColor.blue, UIColor.green, UIColor.purple, UIColor.orange, UIColor.blue, UIColor.green, UIColor.blue, UIColor.green, UIColor.red, UIColor.green, UIColor.blue, UIColor.green, UIColor.purple, UIColor.orange, UIColor.blue, UIColor.green, UIColor.blue, UIColor.green]
    

    var collectionView: UICollectionView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: String(describing:CollectionViewCell.self))
        
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .white
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self


        getTheData()
    }
    private func setupView() {
        setUpFlowAndCollectionView()
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        collectionView.pinToSidesOfsuperView(spacingFrom: 1)
    }
    
    private func setUpFlowAndCollectionView() {
        let layout = UICollectionViewFlowLayout()
        // size
        layout.itemSize = CGSize(width: 300, height: 200)
        // insets
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        // direction
        layout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
//        self.view = collectionView
    }

}

extension CollectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath.row)")
    }

}

extension CollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        apiResponse.results?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing:CollectionViewCell.self), for: indexPath)
                as? CollectionViewCell
        else {
            fatalError("could not dequeu it ")
        }
        let dataItem = data[indexPath.item]
        guard let post = apiResponse.results?[indexPath.item]else { fatalError("nothing doing")}
        let description = post.description ?? "No text retreived"
        
        
        cell.doUpdate(color: dataItem)
        cell.doUpdateText(text: description)
        
        return cell
    }
    
}

extension CollectionViewController {
    
    fileprivate func getTheData() {
        
        print(" in \(#function) at line \(#line)")
    
        let accessKey = "bbc33cc9f86e189e1387e31a57dbd74a2dba4a5f4540f7a0dbcb599fd72f61f2"
        
        guard let theURL = URL(string: "https://api.unsplash.com/search/photos?query=puppies") else {
            fatalError("error converting url")
        }
        
        var req = URLRequest(url: theURL)
        req.addValue("Client-ID \(accessKey)", forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: req) {  data, response, error in
            
            if error != nil {
                print("there was an error")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print(response)
              return
            }

            
            guard let data = data else {
                fatalError("data not retreived")
            }
            print(String(decoding: data, as: UTF8.self))
             //do the decoding from here
            print(" in \(#function) at line \(#line)")
            do {
                let xxxx = try JSONDecoder().decode(APIResponse.self, from: data)
                self.apiResponse = xxxx
//                print(" in \(#function) at line \(#line)")
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
//                self.apiResponse.results.forEach {
//                    print($0.description as Any)
//
//                }
            } catch let error {
                print("error decoding the response \(error)")
            }
            
        }
        task.resume()
        
    }
    
}
