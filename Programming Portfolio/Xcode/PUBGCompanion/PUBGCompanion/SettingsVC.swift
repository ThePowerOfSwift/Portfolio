//
//  SettingsVC.swift
//  PUBGCompanion
//
//  Created by Kel Robertson on 12/09/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit
import Kanna
import Alamofire
import AlamofireImage
import NVActivityIndicatorView

class SettingsVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var ViewTitle: UINavigationItem!
    
    @IBOutlet weak var okButton: UIButton!
    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var userInputField: CustomTextField!
    
    @IBOutlet weak var messageField: UILabel!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    var activity: NVActivityIndicatorView!

    var playerInfo:PlayerInfo!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.userInputField.isHidden = false
        okButton.layer.cornerRadius = 5
        okButton.isHidden = true
        userName.isHidden = true
        userImage.isHidden = true
        userInputField.delegate = self
        messageLabel.isHidden = true
        ViewTitle.title = "Settings"
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SettingsVC.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
        
        if let name = UserDefaults.standard.string(forKey: "playerName") {
            if name != "" {
                self.userInputField.isHidden = false
                LoadActivity()
                PUBGTRACKER.instance.PlayerData(name: name, completed: { (success, msg) in
                    if (success)! {
                        self.activity.stopAnimating()
                        self.playerInfo = PUBGTRACKER.instance.playerInfo
                        Alamofire.request((self.playerInfo?.avatar)!).responseImage(completionHandler: { (response) in
                            self.userImage.image = response.result.value
                        })
                        self.userName.text = self.playerInfo?.playerName
                        self.okButton.isHidden = false
                        self.userName.isHidden = false
                        self.userImage.isHidden = false
                    }
                })
            }
        }
        

    }
    @IBAction func sPressed(_ sender: Any) {
        UserDefaults.standard.set("", forKey: "playerName")
        self.navigationController?.popViewController(animated: true)

        
    }
    
    @IBAction func okPressed(_ sender: Any) {
        LoadActivity()
        if let user = userName.text  {
            if user != UserDefaults.standard.string(forKey: "playerName") {
                UserDefaults.standard.set(user, forKey: "playerName")
                let a = self.navigationController?.viewControllers[0] as! HomeVC
                a.mTitle = user
                if let cell = a.mainMenuCV.cellForItem(at: IndexPath(row: 0, section: 0)) as? MainMenuCell {
                    cell.sectionTitle.text = "Stats"
                }
                self.navigationController?.popViewController(animated: true)
            } else {
                self.navigationController?.popViewController(animated: true)

            }

        }
        
    }
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.messageLabel.isHidden = true
        self.userName.isHidden = true
        self.userImage.isHidden = true
        textField.resignFirstResponder()
        LoadActivity()
        if let userSearch = userInputField.text {
            PUBGTRACKER.instance.PlayerData(name: userSearch, completed: { (success, msg) in
                if (success)! {
                    self.activity.stopAnimating()
                    self.playerInfo = PUBGTRACKER.instance.playerInfo
                    Alamofire.request((self.playerInfo?.avatar)!).responseImage(completionHandler: { (response) in
                        self.userImage.image = response.result.value
                    })
                    self.userName.text = self.playerInfo?.playerName
                    self.okButton.isHidden = false
                    self.userName.isHidden = false
                    self.userImage.isHidden = false
                    self.messageLabel.text = "Is this the Account you wish to setup? PRESS OK"
                    self.messageLabel.isHidden = false
                } else {
                    self.messageLabel.text = "An Error Occured of Player Does Not Exist, Please try again"
                    self.messageLabel.isHidden = false
                }
            })
        }
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
}
