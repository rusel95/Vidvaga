//
//  AboutVC.swift
//  Vidvaga
//
//  Created by Alexander on 17.05.17.
//  Copyright © 2017 rusel95. All rights reserved.
//

import Foundation
import UIKit

class AboutVC: UIViewController {
    
    @IBOutlet weak var aboutTxt: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        aboutTxt.text = "This program created for ATO soldiers."
    }
}
