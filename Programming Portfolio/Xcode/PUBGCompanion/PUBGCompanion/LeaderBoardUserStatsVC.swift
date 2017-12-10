//
//  LeaderBoardUserStatsVC.swift
//  PUBGCompanion
//
//  Created by Kel Robertson on 13/09/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import NVActivityIndicatorView
import Kanna

typealias comp = (_ suc: Bool?) -> Void

class LeaderBoardUserStatsVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var statsTableView: UICollectionView!
    @IBOutlet weak var userImage: UIImageView!

    
    @IBOutlet weak var wins: UILabel!
    @IBOutlet weak var kills: UILabel!
    @IBOutlet weak var roundsPlayed: UILabel!

    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var statView: UIView!
    @IBOutlet weak var statView1: UIView!
    @IBOutlet weak var statView2: UIView!
    @IBOutlet weak var statView3: UIView!
    @IBOutlet weak var statView4: UIView!
    @IBOutlet weak var statView5: UIView!
    @IBOutlet weak var lastUpdated: UILabel!
    @IBOutlet weak var statsInfo: UILabel!
    
    var statsInfoPre: String!
    
    var season: String!
    var region: String!
    var userName: String!
    var dataHTML: String!
    
    var stats = [Stats]()
    var playerInfo = PUBGTRACKER.instance.searchPlayerInfo
    var currentSeason = PUBGTRACKER.instance.searchPlayerInfo.currentSeason
    var activity: NVActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadActivity()
        userLabel.isHidden = true
        statView.isHidden = true
        statsTableView.delegate = self
        statView.layer.cornerRadius = 5
        statView1.layer.cornerRadius = 5
        statView2.layer.cornerRadius = 5
        statView3.layer.cornerRadius = 5
        statView4.layer.cornerRadius = 5
        statView5.layer.cornerRadius = 5
        statsInfo.text = statsInfoPre
        if statsInfo.text == "" {
            statsInfo.isHidden = true
        } else {
            statsInfo.isHidden = false
        }
        ParseHTML()
    }

    
    func ParseHTML(){

        
        stats.removeAll()
        for statistics in PUBGTRACKER.instance.searchStats {
            if statistics.Season == currentSeason {
                self.stats.append(statistics)
            }
        }
        self.wins.text = playerInfo?.OAWins
        self.kills.text = playerInfo?.OAKills
        self.roundsPlayed.text = playerInfo?.OAMatchesPlayed
        Alamofire.request((playerInfo?.avatar)!).responseImage { (response) in
        self.userImage.image = response.result.value
        }
        self.statsInfo.text = "\((PUBGME.instance.ReturnSeasonString(season: (playerInfo?.currentSeason)!)))"
        self.userLabel.isHidden = false
        self.statView.isHidden = false
        self.userLabel.text = playerInfo?.playerName
        self.lastUpdated.text = "\((playerInfo?.lastUpdated.uppercased())!) AGO"
        self.statsTableView.dataSource = self
        self.statsTableView.reloadData()
        self.activity.stopAnimating()
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
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stats.count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let stat = stats[indexPath.row]
        performSegue(withIdentifier: "showExtendedStat", sender: stat)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showExtendedStat" {
            if let destination = segue.destination as? ShareVC {
                destination.stat = sender as! Stats
                destination.pName = playerInfo?.playerName.uppercased()
                destination.pImage = playerInfo?.pImage
                destination.lastUpdated = playerInfo?.lastUpdated
            }
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
}
