//
//  BookmarksTableViewCell.swift
//  Vidvaga
//
//  Created by Admin on 16.05.17.
//  Copyright © 2017 rusel95. All rights reserved.
//

import UIKit

class BookmarksTableViewCell: UITableViewCell {
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postTextLabel: UILabel!
    @IBAction func actionBookmark(_ sender: Any) {
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setPostWith(_ post: Post) {
        postImageView.image = UIImage(data: post.image)
        postTitleLabel.text = post.title
        postTitleLabel.text = post.text
    }
    
    
    
}
