//
//  Post.swift
//  Vidvaga
//
//  Created by Admin on 13.05.17.
//  Copyright © 2017 rusel95. All rights reserved.
//

import Foundation
import RealmSwift

class Post : Object  {
    dynamic var id : Int = 0
    dynamic var title : String = ""
    dynamic var text : String = ""
    dynamic var image : Data = Data()
    dynamic var date : String = ""
    dynamic var type: String = ""
    
    func setPost(id: Int, title: String, text: String, image: Data, date: String, type: String) -> Object {
        self.id = id
        self.title = title
        self.text = text
        self.image = image
        self.date = date
        self.type = type
        
        return self
    }
}

