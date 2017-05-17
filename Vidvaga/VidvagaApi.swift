//
//  VidvagaApi.swift
//  Vidvaga
//
//  Created by Admin on 13.05.17.
//  Copyright © 2017 rusel95. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage
import SwiftyJSON
import RealmSwift

class VidvagaApi {
    static let shared = VidvagaApi()
    private init () { }
    
    private let newsURL = "http://dev.inkubator-up.co.ua/api/v1/news"
    private var imageUrls = [String]()
    
    func downloadNews(completion: @escaping ([Post]?) -> Void) {
        var newsFeed: [Post] = []

        Alamofire.request(newsURL).responseJSON { response in
            if let json = response.result.value {

                let responseJson = json as? [[String: AnyObject]]
                for item in responseJson!   {
                    let postId = item["id"] as! Int
                    let postTitle = item["title"] as! String
                    let postText = item["text"] as! String
                    
                    
                    let postDate = item["date"] as! Int
                    let postType = item["type"] as! String
                    
                    
                    
                    let postImageString = item["image"] as! String
                    self.imageUrls.append(postImageString)
                    
                    let post = Post().setPost(id: postId, title: postTitle, text: postText, image: Data(), date: String(postDate), type: postType)
                    newsFeed.append(post as! Post)
                }
            }
            completion(newsFeed)
        }
    }
    
    func getImageUrls() -> [String] {
        return imageUrls
    }
    
}
