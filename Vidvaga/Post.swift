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
    dynamic var type: String = ""
    
    func myInit(response: [String:Any]) -> Object {
  
        let postId = response["id"] as! Int
        let postTitle = response["title"] as! String
        let postText = response["text"] as! String
        let postDate = response["date"] as! Int
        let postType = response["type"] as! String
        
        setPost(id: postId, title: postTitle, text: postText, date: String(postDate), type: postType)
        return (self)
    }
    
    func getString(response: [String:Any]) -> String {
        let postImageString = response["image"] as! String
        return postImageString
    }
    
    func setPost(id: Int, title: String, text: String, date: String, type: String) {
        self.id = id
        self.title = title
        self.text = text
        self.date = date
        self.type = type
    }
}


