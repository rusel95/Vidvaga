//
//  RealmCRUD.swift
//  Vidvaga
//
//  Created by Admin on 13.05.17.
//  Copyright © 2017 rusel95. All rights reserved.
//

import Foundation
import RealmSwift

class RealmCRUD {
    
    static let shared = RealmCRUD()
    private init () { }
    
    func write(somePost: Post) {
        
        if !isExist(somePost: somePost) {
            
            let realm = try! Realm()
            
            try! realm.write {
                realm.add(somePost)
            }
        }
    }
    
    func queryPostsToArray() -> [Post] {
        
        var objects = [Post]()
        
        let realm = try! Realm()
        let posts = realm.objects(Post.self)
        for post in posts {
            objects.append(post)
        }
        
        return objects
    }
    
    func isExist(somePost: Post) -> Bool {
        
        var exist = false
        
        let posts = self.queryPostsToArray()
        for post in posts {
            if post.id == somePost.id {
                exist = true
                break
            }
        }
        
        return exist
    }
    
    func deletePost(postToDelete: Post) -> Void {
        
        let realm = try! Realm()
        
        for post in queryPostsToArray() {
            if post.id == postToDelete.id{
                try! realm.write {
                    realm.delete(post)
                }
                break
            }
        }
    }
    
    func deleteAllPosts() -> Void {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
    }
}
