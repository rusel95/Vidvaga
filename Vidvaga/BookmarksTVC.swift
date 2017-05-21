//
//  BoormarksTableViewController.swift
//  Vidvaga
//
//  Created by Admin on 16.05.17.
//  Copyright © 2017 rusel95. All rights reserved.
//

import UIKit

class BoormarksTableViewController: UITableViewController, BookmarksViewControllerDelegate {
    
    fileprivate var allPosts = [Post]()
    //    fileprivate var allTitles = Set<String>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addRandomToBookmarks()
        
        allPosts = RealmCRUD.shared.queryPostsToArray()
        
    }

    
    func addRandomToBookmarks() {
        let post = Post()
        post.title = "some second title in here"
        RealmCRUD.shared.write(somePost: post)
    }
    
    // MARK: - Table view data source
    //
    //    override func numberOfSections(in tableView: UITableView) -> Int {
    //        return allTitles.count
    //    }
    //
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allPosts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookmarksCell", for: indexPath) as! BookmarksTableViewCell
        
        //cell.setPostWith(allPosts[indexPath.row])
        cell.currentPost = allPosts[indexPath.row]
        cell.delegate = self
        
        return cell
    }
    
    //MARK: Delegeted function
    func delete(bookmark: Post) {
        var index = 0
        for i in 0..<allPosts.count {
            if bookmark == allPosts[i] {
                index = i
            }
        }
        let indexPath = IndexPath(row: index, section: 0)
        RealmCRUD.shared.deletePost(postToDelete: allPosts[index])
        allPosts.remove(at: index)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}
