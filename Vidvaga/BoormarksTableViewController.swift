//
//  BoormarksTableViewController.swift
//  Vidvaga
//
//  Created by Admin on 16.05.17.
//  Copyright © 2017 rusel95. All rights reserved.
//

import UIKit

class BoormarksTableViewController: UITableViewController {

    fileprivate var allPosts = [Post]()
//    fileprivate var allTitles = Set<String>()

    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        allPosts = RealmCRUD.shared.queryPostsToArray()
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

        cell.setPostWith(allPosts[indexPath.row])
        cell.postTitleLabel.text = "Ddcxvbcvbljad;lfkjgadf;kj"
        return cell
    }
}
