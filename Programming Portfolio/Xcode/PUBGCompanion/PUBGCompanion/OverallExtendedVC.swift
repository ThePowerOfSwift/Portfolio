//
//  OverallExtendedVC.swift
//  PUBGCompanion
//
//  Created by Kel Robertson on 16/09/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit
import Kanna
import Alamofire
import DropDown
import NVActivityIndicatorView

typealias completedScrape = (_ success:Bool) -> Void

class OverallExtendedVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var statsTableView: UICollectionView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var overallLabel: UILabel!
    
    @IBOutlet weak var previousSeasonButton: UIButton!
    
    @IBOutlet weak var SharePressed: UIButton!
    
    @IBOutlet weak var wins: UILabel!
    @IBOutlet weak var kills: UILabel!
    @IBOutlet weak var roundsPlayed: UILabel!
    @IBOutlet weak var longestKill: UILabel!
    @IBOutlet weak var heals: UILabel!
    @IBOutlet weak var timeAlive: UILabel!
    
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var statView: UIView!
    var activity: NVActivityIndicatorView!
    var userName = UserDefaults.standard.object(forKey: "playerName")
    
    var stats = [Stats]()
    var previousSeason = [Stats]()
    var playerInfo = PUBGTRACKER.instance.playerInfo
    
    var dropDown = DropDown()
    var regionDropDown = DropDown()
    var regionDropDownData = [String]()
    var dropdownData = [String]()
    var LK = [Double]()
    var H = 0
    var TA = 0.0
    var currentSeason: String!
    var selectedSeason: String!

    
    @IBOutlet weak var searchViewConst: NSLayoutConstraint!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchViewTextField: CustomTextField!
    @IBOutlet weak var searchViewSearchButton: UIButton!
    @IBOutlet weak var searchViewErrorLabel: UILabel!
    @IBOutlet weak var searchCancelButton: UIButton!
    
    
    override func viewWillAppear(_ animated: Bool) {
        currentSeason = PUBGTRACKER.instance.playerInfo.currentSeason
        stats.removeAll()
        LK.removeAll()
        H = 0
        TA = 0.0
        for statistics in PUBGTRACKER.instance.stats {
            if statistics.Season == PUBGTRACKER.instance.playerInfo.currentSeason {
                    self.stats.append(statistics)
                LK.append(statistics.individualStats.LK)
                H += (statistics.individualStats.H)
                TA += (statistics.individualStats.TA)
            }
            
        }

        self.parent?.navigationItem.title = PUBGME.instance.ReturnSeasonString(season: currentSeason)
        self.userLabel.text = userName as? String
        self.wins.text = playerInfo?.OAWins
        self.kills.text = playerInfo?.OAKills
        self.longestKill.text = "\(LK.max()!)m"
        self.heals.text = "\(H)"
        self.timeAlive.text = stringFromTimeInterval(interval: TA) as String
        self.roundsPlayed.text = playerInfo?.OAMatchesPlayed
        self.userImage.image = playerInfo?.pImage
        self.statsTableView.delegate = self
        self.statsTableView.dataSource = self
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        searchViewErrorLabel.text = "Search for a player by entering thier PUBG username above."
        searchView.layer.cornerRadius = 5
        searchCancelButton.layer.cornerRadius = 8
        searchViewSearchButton.layer.cornerRadius = 5
    }
    
    func SetupData(){
        for stat in PUBGTRACKER.instance.stats {
            let season = PUBGME.instance.ReturnSeasonString(season: stat.Season)
                if stat.Season != currentSeason, stat.Region != "agg" {
                    dropdownData.append(season)
                }
        }
        
        dropDown.dataSource = dropdownData.uniqueElements
        dropDown.anchorView = previousSeasonButton.titleLabel?.plainView
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.selectedSeason = item
            self.PreviousSeasonData(season: item)
            self.performSegue(withIdentifier: "previousSeason", sender: nil)
        }
    
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "previousSeason" {
            if let controller = segue.destination as? PreviousSeasonsVC {
                controller.cellData = previousSeason
                controller.seasonTitle = selectedSeason
            }
        } else if segue.identifier == "showExtendedStat" {
            if let destination = segue.destination as? ShareVC {
                destination.stat = sender as! Stats
                destination.pName = playerInfo?.playerName.uppercased()
                destination.pImage = playerInfo?.pImage
                destination.lastUpdated = playerInfo?.lastUpdated
            }
        }
        
    }
    
    func PreviousSeasonData(season: String){
        self.previousSeason.removeAll()
        let sea = PUBGME.instance.ReturnSeasonHref(season: season)
        for stats in PUBGTRACKER.instance.stats {
            if stats.Season == sea, stats.Region != "agg" {
                previousSeason.append(stats)
            }
        }
    }
    
    func ComparePressed(sender: UIBarButtonItem) {
        searchViewErrorLabel.text = "Search for a player by entering thier PUBG username above."
        searchView.layer.cornerRadius = 5
        searchViewConst.constant = -200
        UIView.animate(withDuration: 0.3) {
            super.view.layoutIfNeeded()
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = stats[indexPath.row]
        if let cell = statsTableView.dequeueReusableCell(withReuseIdentifier: "statisticsCell", for: indexPath) as? StatisticsCell {
            cell.ConfigureCell(stat: data)
            cell.layer.cornerRadius = 5
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (collectionView.bounds.width - 20), height: 135)
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let stat = stats[indexPath.row]
        performSegue(withIdentifier: "showExtendedStat", sender: stat)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stats.count
    }
    
    func LoadActivity(){
        let screenWidth = self.view.frame.size.width
        let screenHeight = self.view.frame.size.width
        activity = NVActivityIndicatorView(frame: CGRect(x: screenWidth / 2 ,y: screenHeight / 2, width: 100 , height:100 ) , type: .ballScaleRippleMultiple, color: Y_ORANGE, padding: 10)
        activity.layer.cornerRadius = 50
        self.view.addSubview(activity)
        self.activity.center.x = self.view.center.x
        activity.backgroundColor = DARK_GREY
    }
    func stringFromTimeInterval(interval: TimeInterval) -> NSString {
        let ti = NSInteger(interval)
        let seconds = ti % 60
        let minutes = (ti / 60) % 60
        let hours = (ti / 3600)
        return NSString(format: "%0.2dh %0.2dm %0.2ds",hours,minutes,seconds)
    }
    
    @IBAction func prevSeasonPressed(_ sender: Any) {
        dropDown.show()
    }
    
    @IBAction func ShareButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "shareControl", sender: nil)
        self.parent?.navigationItem.title = ""
    }
    
    @IBAction func searchViewSearchButtonPressed(_ sender: Any) {
        let currentUser = playerInfo?.playerName.lowercased()
        if let searchName = searchViewTextField.text {
           let parentVC = parent as? StatsPagePVC
            parentVC?.LoadActivity()
            if searchName.isEmpty == true {
                parentVC?.activity.stopAnimating()
                searchViewErrorLabel.text = "Enter a player name above and tap search"
            } else if searchName.lowercased() != currentUser {
                searchViewConst.constant = -500
                UIView.animate(withDuration: 0.3) {
                    super.view.layoutIfNeeded()
                }
                
                PUBGTRACKER.instance.SerachPlayerData(name: searchName, completed: { (success, msg) in
                    if (success)! {
                        parentVC?.activity.stopAnimating()
                        self.searchViewTextField.text = ""
                        self.performSegue(withIdentifier: "comparePlayers", sender: nil)
                    }
                })
                
            } else {
                parentVC?.activity.stopAnimating()
                searchViewTextField.text = ""
                searchViewErrorLabel.text = "Error: You cannot compare yourself."
            }
            
        }
    }
    
    @IBAction func cancelSearchPressed(_ sender: Any) {
        searchViewConst.constant = -500
        UIView.animate(withDuration: 0.3) {
            super.view.layoutIfNeeded()
        }
    }
    
    
}
