//
//  FeedViewController.swift
//  passthepiece
//
//  Created by brianna on 11/19/17.
//  Copyright © 2017 brianna. All rights reserved.
//

import UIKit
import AlamofireImage

class FeedViewController: UIViewController {
    
    var feed: [Post] = []
    var details: [PostContentViewController] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set up
        setUpCollectionView()
        setDemoContent()
    }
    
    // MARK: - Setup
    
    fileprivate func setUpCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        //Set background gradient
        self.collectionView.backgroundView = UIImageView(image: #imageLiteral(resourceName: "gradient"))
    }
    
    fileprivate func setDemoContent() {
        let demo = Post(caption: "#excited", strain: "Blue Dream", comments: [], image: URL(string: "https://www.cannabisreports.com/images/strains/1/full_1e54eaa60d64f80c167bc392abaae7704a1ef057.jpg"), ownerImage: nil, ownerHandle: "@bornbrie")
        feed.append(demo)
        feed.append(demo)
        feed.append(demo)
        feed.append(demo)
        feed.append(demo)
        feed.append(demo)
        feed.append(demo)
        feed.append(demo)
    }

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

}

extension FeedViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feed.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedCell", for: indexPath) as! FeedCollectionViewCell
        let post = feed[indexPath.row]
        
//        cell.card.buttonText = "🤘"
        cell.card.textColor = .white
        
        cell.card.title = post.strain ?? ""
        cell.card.subtitle = post.caption ?? ""
        cell.card.category = post.ownerHandle ?? ""
        
        //Set background / main image
        cell.card.backgroundColor = .clear
        cell.card.backgroundImage = #imageLiteral(resourceName: "blue dream")
        imageFrom(url: post.image) { image in
            cell.card.backgroundImage = image
        }
        
        //Set owner image
//        imageFrom(url: post.ownerImage) { ownerImage in
//            let image = ownerImage ?? UIImage(named: "stoner") ?? UIImage()
//            cell.card.icon = image
//        }
        
        //Set Post Content View Controller and child Post
        let contentVC = details[safe: indexPath.row] ?? storyboard?.instantiateViewController(withIdentifier: "PostContent") as! PostContentViewController
        cell.card.shouldPresent(contentVC, from: self)
        contentVC.post = post
        
        //Required for back drop shadow from cell.card
        cell.clipsToBounds = false
        cell.contentView.clipsToBounds = false
        
        //Set border on cell
        cell.card.layer.borderColor = UIColor.white.cgColor
        cell.card.layer.borderWidth = 3
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return false
    }
}

extension Collection {
    
    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension UIImage {
    static func imageWithColor(tintColor: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        tintColor.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}

extension UIViewController {
    func imageFrom(url: URL?, complete: @escaping (_ image: UIImage?)->()) {
        
        let imageDownloader = ImageDownloader()
        
        guard let url = url else {
            complete(nil)
            return
        }
        
        let request = URLRequest(url: url)
        imageDownloader.download(request) { response in
            guard let image = response.result.value else {
                complete(nil)
                return
            }
            complete(image)
        }
    }
}
