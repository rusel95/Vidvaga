//
//  PostDetailsVC.swift
//  Vidvaga
//
//  Created by Admin on 29.05.17.
//  Copyright © 2017 rusel95. All rights reserved.
//

import UIKit

class PostDetailsVC: UIViewController {
    
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionText: UITextView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var descriptionTextHeight: NSLayoutConstraint!
    
    var post = Post()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func setUI() {
        typeLabel.text = post.type
        
        let date = Date(timeIntervalSince1970: Double(post.date)!)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM YYYY"
        let dateString = dateFormatter.string(from: date)
        dateLabel.text = dateString
        
        titleLabel.text = post.title
        descriptionText.text = post.text
    }
}
