//
//  Post.swift
//  Vidvaga
//
//  Created by Admin on 13.05.17.
//  Copyright © 2017 rusel95. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON
import AlamofireImage

class Post : Object  {
    dynamic var id : Int = 0
    dynamic var title : String = ""
    dynamic var text : String = ""
    dynamic var image : Data = Data()
    dynamic var date : String = ""
    dynamic var tags : String = ""
    dynamic var type: String = ""
    
    func myInit(response: [String:Any]) -> Object {
  
//        let json = JSON(response)
//        self.id = json["id"].int!
//        self.title = json["title"].string!
        
        let postId = response["id"] as! Int
        let postTitle = response["title"] as! String
        let postText = response["text"] as! String
        let postDate = response["date"] as! Int
        let postTags = response["tags"] as! String
        let postType = response["type"] as! String
        
        setPost(id: postId, title: postTitle, text: postText, date: String(postDate), tags: postTags, type: postType)
        return (self)
    }
    
    func getString(response: [String:Any]) -> String {
        let postImageString = response["image"] as! String
        return postImageString
    }
    
    func setPost(id: Int, title: String, text: String, date: String, tags: String, type: String) {
        self.id = id
        self.title = title
        self.text = text
        self.date = date
        self.tags = tags
        self.type = type
    }
}


