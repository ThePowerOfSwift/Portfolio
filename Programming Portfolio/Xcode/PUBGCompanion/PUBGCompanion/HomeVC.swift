//
//  HomeVC.swift
//  PUBGCompanion
//
//  Created by Kel Robertson on 30/08/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit
import SwiftyJSON
import NVActivityIndicatorView
import GoogleMobileAds


class HomeVC: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, GADBannerViewDelegate {
    
    @IBOutlet weak var yContraint: NSLayoutConstraint!
    @IBOutlet weak var adBanner: GADBannerView!
    @IBOutlet weak var adBannerHeight: NSLayoutConstraint!
    @IBOutlet weak var MenuTitle: UINavigationItem!
    @IBOutlet weak var mainMenuCV: UICollectionView!
    @IBOutlet weak var noInternetView: UIView!
    @IBOutlet weak var noInternetYConstraint: NSLayoutConstraint!
    @IBOutlet weak var disclaimerView: UIView!
    @IBOutlet weak var adC: NSLayoutConstraint!
    
    var mTitle = UserDefaults.standard.string(forKey: "playerName")
    var activity: NVActivityIndicatorView!
    var homeMenuItems = ["Stats","Search Players","Leaderboards","Weapons","Items","Maps"]
    var homeMenuImg = ["STATS_ICON","SEARCH_ICON","LEADERBOARD_ICON","WEAPONS_ICON","ITEMS_ICON","MAPS_ICON"]
    var uData = [String:JSON]()
    var updating: Bool! = false
    
    override func viewDidAppear(_ animated: Bool) {
        if mTitle != "" && mTitle != nil{

            if let cell = mainMenuCV.cellForItem(at: IndexPath(row: 0, section: 0)) as? MainMenuCell {
                cell.sectionTitle.text = "Updating Stats"
                PUBGTRACKER.instance.PlayerData(name: mTitle!, completed: { (success, msg) in
                    if (success)! {
                        DispatchQueue.main.async {
                            cell.sectionTitle.text = "Stats"
                            self.updating = false
                        }
                        
                    }
                })
            }
        } else {
            if let cell = mainMenuCV.cellForItem(at: IndexPath(row: 0, section: 0)) as? MainMenuCell {
                 cell.sectionTitle.text = "Enable Stats"
            }
        }
        DispatchQueue.global(qos: .background).async {
            PUBGMEItems.instance.PubgItems()
        }
        
        

        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.adBanner.adUnitID = ADUNITID
        self.adBanner.rootViewController = self
        self.adBanner.plainView.backgroundColor = LIGHT_GREY
        let request = GADRequest()
        self.adBanner.load(request)
                NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActive), name: .UIApplicationDidBecomeActive, object: nil)
        self.mainMenuCV.dataSource = self
        self.mainMenuCV.delegate = self

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self,name: .UIApplicationDidBecomeActive,object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        MenuTitle.title = mTitle
        checkIntenet()
    }
    func applicationDidBecomeActive() {
        
        checkIntenet()
//        mTitle = UserDefaults.standard.string(forKey: "playerName")
//        if mTitle != nil {
//            MenuTitle.title = mTitle
//            if let cell = mainMenuCV.cellForItem(at: IndexPath(row: 0, section: 0)) as? MainMenuCell {
//                cell.sectionTitle.text = "Updating Stats"
//                PUBGTRACKER.instance.PlayerData(name: mTitle!, completed: { (success, msg) in
//                    if (success)! {
//                        DispatchQueue.main.async {
//                            cell.sectionTitle.text = "Stats"
//                            self.updating = false
//                        }
//                        
//                    }
//                })
//            }
//            
//            
//        } else if mTitle == "", mTitle == nil {
//            if let cell = mainMenuCV.cellForItem(at: IndexPath(row: 0, section: 0)) as? MainMenuCell {
//                cell.sectionTitle.text = "Enable State"
//            }
//        }
    }
    
    func checkIntenet(){
        if currentReachabilityStatus != .notReachable
        {
            noInternetView.layer.cornerRadius = 5
            noInternetYConstraint.constant = -600
            UIView.animate(withDuration: 0.3) {
                super.view.layoutIfNeeded()
            }
            
            
            self.navigationItem.rightBarButtonItem?.isEnabled = true
            self.navigationItem.leftBarButtonItem?.isEnabled = true
        }
        else
        {
            noInternetView.layer.cornerRadius = 5
            noInternetYConstraint.constant = 0
            UIView.animate(withDuration: 0.3) {
                super.view.layoutIfNeeded()
            }
            self.navigationItem.rightBarButtonItem?.isEnabled = false
            self.navigationItem.leftBarButtonItem?.isEnabled = false
            mainMenuCV.dataSource = nil
            mainMenuCV.delegate = nil
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.width - 30), height: ((collectionView.bounds.height - CGFloat(homeMenuItems.count * 28)) / CGFloat(homeMenuItems.count)))
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let menuCell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainMenuCell", for: indexPath) as? MainMenuCell{
            menuCell.ConfigureCell(homeMenuItems[indexPath.row], img: homeMenuImg[indexPath.row])
            menuCell.layer.masksToBounds = true
            menuCell.layer.cornerRadius = 6
            return menuCell
        }

        return UICollectionViewCell()
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeMenuItems.count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            if mTitle != "" && mTitle != nil {
                if updating == false {
                    performSegue(withIdentifier: "battlegroundsStats", sender: nil)
                }
            } else {
                performSegue(withIdentifier: "showSettings", sender: nil)
            }
            break
        case 1:
                performSegue(withIdentifier: "searchPlayer", sender: nil)
            break
        case 2:
            performSegue(withIdentifier: "showLeaderboard", sender: nil)
            break
        case 3:
            performSegue(withIdentifier: "weapons", sender: nil)
            break
        case 4:
            performSegue(withIdentifier: "showItems", sender: nil)
            break
        case 5:
            performSegue(withIdentifier: "showMap", sender: nil)
            break
        default:
            break
        }
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
    
    @IBAction func disclaimerPressed(_ sender: Any) {
        yContraint.constant = 0
        UIView.animate(withDuration: 0.3) {
            super.view.layoutIfNeeded()
        }
    }
    

    @IBAction func dismissPressed(_ sender: Any) {
        yContraint.constant = -700
        UIView.animate(withDuration: 0.3) {
            super.view.layoutIfNeeded()
        }
    }
    
    @IBAction func settingsPressed(_ sender: Any) {
        performSegue(withIdentifier: "showSettings", sender: nil)
    }
}
