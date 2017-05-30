//
//  BookmarksTableViewCell.swift
//  Vidvaga
//
//  Created by Admin on 16.05.17.
//  Copyright © 2017 rusel95. All rights reserved.
//

import UIKit

protocol BookmarksViewControllerDelegate {
    func delete(bookmark: Post)
}

class BookmarksTableViewCell: UITableViewCell {
    
    var delegate : BookmarksViewControllerDelegate?
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBAction func actionBookmark(_ sender: Any) {
        self.delegate?.delete(bookmark: currentPost)
    }
    
    var currentPost = Post() {
        didSet {
            postTitleLabel.text = currentPost.title
        }
    }
    
}
