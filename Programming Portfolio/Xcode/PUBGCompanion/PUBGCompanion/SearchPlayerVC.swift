//
//  SearchPlayerVC.swift
//  PUBGCompanion
//
//  Created by Kel Robertson on 15/09/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit
import Kanna
import Alamofire
import NVActivityIndicatorView
import GoogleMobileAds

class SearchPlayerVC: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var searchField: CustomTextField!
    @IBOutlet weak var seachButton: UIButton!
    @IBOutlet weak var adBanner: GADBannerView!
    
    var activity: NVActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infoLabel.text = ""
        searchField.delegate = self
        seachButton.layer.cornerRadius = 5
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SettingsVC.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
        adBanner.adUnitID = ADUNITID
        adBanner.rootViewController = self
        let request = GADRequest()
        
        adBanner.load(request)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPlayerStats" {
            if let destination = segue.destination as? LeaderBoardUserStatsVC {
                destination.userName = searchField.text
                searchField.text?.removeAll()
            }
        }
    }
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    func LoadActivity(){
        let screenWidth = self.view.frame.size.width
        let screenHeight = self.view.frame.size.width
        activity = NVActivityIndicatorView(frame: CGRect(x: screenWidth / 2 ,y: screenHeight / 2, width: 100 , height:100 ) , type: .ballScaleRippleMultiple, color: Y_ORANGE, padding: 10)
        self.view.addSubview(activity)
        activity.center.x = self.view.center.x
        activity.layer.cornerRadius = 50
        activity.backgroundColor = DARK_GREY
        activity.startAnimating()
    }
    @IBAction func searchPressed(_ sender: Any) {
        if let searchName = searchField.text {
            if searchName.isEmpty == true {
                infoLabel.text = "Enter a player name below and tap search"
            } else {
                self.LoadActivity()
                PUBGTRACKER.instance.SerachPlayerData(name: searchName, completed: { (success, msg) in
                    if (success)! {
                        self.performSegue(withIdentifier: "showPlayerStats", sender: nil)
                        self.activity.stopAnimating()
                    }
                })
                
            }
            
        }
    }
    
}
