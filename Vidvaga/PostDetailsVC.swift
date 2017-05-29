//
//  PostDetailsVC.swift
//  Vidvaga
//
//  Created by Admin on 29.05.17.
//  Copyright © 2017 rusel95. All rights reserved.
//

import UIKit

class PostDetailsVC: UIViewController {
    
    @IBOutlet weak var newsImg: UIImageView!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionTxt: UITextView!
    
    var post = Post()
    var postUrl = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func setUI() {
        newsImg.af_setImage(withURL: URL(string: postUrl)!)
        typeLbl.text = post.type
        
        let date = Date(timeIntervalSince1970: Double(post.date)!)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM YYYY"
        let dateString = dateFormatter.string(from: date)
        dateLbl.text = dateString
        
        titleLbl.text = post.title
        descriptionTxt.text = post.text
    }
}
