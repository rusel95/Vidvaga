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
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        print("Init_ResultViewController")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("Init_ResultViewController")
    }
    
    deinit {
        print("deinit_ResultViewController")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        allPosts = RealmCRUD.shared.queryPostsToArray()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allPosts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookmarksCell", for: indexPath) as! BookmarksTableViewCell
        
        cell.currentPost = allPosts[indexPath.row]
        cell.delegate = self
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = allPosts[indexPath.row]
        
        self.performSegue(withIdentifier: "showDetails", sender: post)
//        let postDetailsVC = storyboard?.instantiateViewController(withIdentifier: "PostDetails") as! PostDetailsVC
//        postDetailsVC.post = post
//        navigationController?.pushViewController(postDetailsVC, animated: true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            let postDetailsVC = segue.destination as! PostDetailsVC
            postDetailsVC.post = sender as! Post
        }
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
