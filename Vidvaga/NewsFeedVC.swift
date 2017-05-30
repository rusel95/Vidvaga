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
    private var newsFeedAny = [[String:Any]]()
    private var newsInDB = [Post]()
    private var imageUrls = [String]()
    private let heightOfRow: CGFloat = 150
    private let heightOfView: CGFloat = 40
    private let sizeOfIcon: CGFloat = 24
    let delimiterHeight: CGFloat = 2
    private var backgroundColor = UIColor.init(red: 239/256, green: 239/256, blue: 244/256, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        newsFeed.removeAll()
        self.newsInDB = RealmCRUD.shared.queryPostsToArray()
        
        VidvagaApi.shared.downloadTopNewsId { (topId) in
            VidvagaApi.shared.downloadNewsById(newsId: topId!, completion: { (topNews) in
                // get top post
            })
        }
        
        VidvagaApi.shared.downloadNews { (result) in
            self.newsFeedAny = result!
            
            for response in self.newsFeedAny {
                let post = Post().myInit(response: response)
                self.newsFeed.append(post as! Post)
                self.imageUrls.append((post as! Post).getString(response: response))
            }
            
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell") as! NewsCell
        let post = newsFeed[indexPath.row]
        
        cell.titleLbl.text = String(post.title)
        cell.newsImg.af_setImage(withURL: URL(string: imageUrls[indexPath.row])!)

        addBookmarkIconOnCell(post: post, cell: cell, indexPath: indexPath)
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
    
    func addDelimiterOnCell(_ cell: UITableViewCell, _ indexPath: IndexPath){
        let frame = CGRect(x:0, y:(heightOfRow - delimiterHeight), width:UIScreen.main.bounds.size.width, height:delimiterHeight)
        let delimiterView = UIImageView.init(frame: frame)
        let delimColor = backgroundColor
        delimiterView.backgroundColor = delimColor
        cell.addSubview(delimiterView)
    }
    
    func handleTapOnBookmark(recognizer: UITapGestureRecognizer){
        let index = recognizer.view?.tag
        let post = newsFeed[index!]
        recognizer.view?.removeFromSuperview()
        
        VidvagaApi.shared.downloadImage(stringUrl: imageUrls[index!], completion: { (data) in
            post.image = data!
            
            RealmCRUD.shared.write(somePost: post)
            
            self.newsInDB.append(post)
            self.tableView.reloadData()
        })
        
    }
    
    func addBookmarkIconOnCell(post: Post, cell: NewsCell, indexPath: IndexPath) {
        let frame = CGRect.init(x: UIScreen.main.bounds.size.width - 30, y: (heightOfRow - heightOfView + (heightOfView - sizeOfIcon)/2), width: sizeOfIcon, height: sizeOfIcon)
        let bookmarkIconView = UIImageView.init(frame: frame)
        bookmarkIconView.tag = indexPath.row
        
        let tapOnBookmarkIcon = UITapGestureRecognizer.init(target: self, action: #selector(handleTapOnBookmark))
        bookmarkIconView.addGestureRecognizer(tapOnBookmarkIcon)
        bookmarkIconView.isUserInteractionEnabled = true
        
        if isPostInBookmarks(somePost: post) {
            bookmarkIconView.image = UIImage.init(named: "like_icon")
        } else {
            bookmarkIconView.image = UIImage.init(named: "unlike_icon")
        }
        
        cell.addSubview(bookmarkIconView)
    }
    
    func isPostInBookmarks(somePost: Post) -> Bool {
        for post in newsInDB {
            if post.id == somePost.id {
                return true
            }
        }
        return false
    }
    
}
