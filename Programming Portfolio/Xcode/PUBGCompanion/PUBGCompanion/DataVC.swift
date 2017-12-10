//
//  DataVC.swift
//  PUBG Hub
//
//  Created by Kel Robertson on 26/10/17.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit

class DataVC: UIViewController {
    
    
    @IBOutlet weak var htmlView: UITextView!
    
    let browser = HBPUBGME.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        browser.currentContent { (obj, err) in
            
            if let doc = obj {
                DispatchQueue.main.async {
                     self.htmlView.text = doc.innerHTML!
                }
               
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
