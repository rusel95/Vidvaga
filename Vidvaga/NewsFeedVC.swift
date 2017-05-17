//
//  NewsFeedVC.swift
//  Vidvaga
//
//  Created by Alexander on 13.05.17.
//  Copyright © 2017 rusel95. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage
import Realm

class NewsFeedVC: UITableViewController {
    
    private var newsFeed = [Post]()
    private var imageUrls = [String]()
    private let heightOfRow: CGFloat = 60
    let delimiterHeight: CGFloat = 2
    private var backgroundColor = UIColor.init(red: 239/256, green: 239/256, blue: 244/256, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        VidvagaApi.shared.downloadNews { (result) in
            self.newsFeed = result!
            self.imageUrls = VidvagaApi.shared.getImageUrls()
            self.tableView.reloadData()
        }
        
    }
    
    func setUI(){
        tableView.backgroundColor = backgroundColor
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsFeed.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! NewsCell
        let post = newsFeed[indexPath.row]
        
        cell.titleLbl.text = String(post.title)
        cell.newsImg.af_setImage(withURL: URL(string: imageUrls[indexPath.row])!)
        
        cell.bookmarkImg.tag = indexPath.row
        let tapOnBookmarkIcon = UITapGestureRecognizer.init(target: self, action: #selector(handleTapOnBookmark))
        cell.bookmarkImg.addGestureRecognizer(tapOnBookmarkIcon)
        cell.bookmarkImg.isUserInteractionEnabled = true
        
        addBookmarkCell(cell: cell)
        addDelimiterOnCell(cell, indexPath)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightOfRow
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = newsFeed[indexPath.row]
        
        let newsDetailsVC = storyboard?.instantiateViewController(withIdentifier: "news_details") as! NewsDetailsVC
        newsDetailsVC.post = post
        newsDetailsVC.postUrl = imageUrls[indexPath.row]
        navigationController?.pushViewController(newsDetailsVC, animated: true)
    }
    
    //MARK: Add delimiter on cell
    func addDelimiterOnCell(_ cell: UITableViewCell, _ indexPath: IndexPath){
        let frame = CGRect(x:0, y:(heightOfRow - delimiterHeight), width:UIScreen.main.bounds.size.width, height:delimiterHeight)
        let delimiterView = UIImageView.init(frame: frame)
        let delimColor = backgroundColor
        delimiterView.backgroundColor = delimColor
        delimiterView.tag = 10
        cell.addSubview(delimiterView)
    }
    
    func handleTapOnBookmark(recognizer: UITapGestureRecognizer){
        let index = recognizer.view?.tag
        let post = newsFeed[index!]
        
        let imageView = UIImageView()
        imageView.af_setImage(withURL: URL(string: imageUrls[index!])!)
        let data = UIImageJPEGRepresentation(imageView.image!, 1.0)
        
        post.image = data!
        print(post.image)
        // Uncomment when merge
//        if RealmCRUD.shared.isExist() {
//            RealmCRUD.shared.write(somePost: post)
//        }
    }
    
    func addBookmarkCell(cell: NewsCell) {
        // Uncomment when merge
//        if RealmCRUD.shared.isExist() {
//            cell.bookmarkImg.image = UIImage.init(named: "like_icon")
//        } else {
//            cell.bookmarkImg.image = UIImage.init(named: "unlike_icon")
//        }
    }
    
}
