//
//  OverallStatsVC.swift
//  PUBGCompanion
//
//  Created by Kel Robertson on 1/09/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit
import DropDown
import Kanna

import NVActivityIndicatorView

typealias onComplete = (_ suc: Bool?) -> Void

class PreviousSeasonsVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var overallStatsCollectionView: UICollectionView!
    
    @IBOutlet weak var overallLabel: UILabel!
    
    var seasonTitle: String!
    
    var cellData = [Stats]()
    var stats = [Stats]()
    var regionHref = [String]()
    var playerInfo = PUBGTRACKER.instance.playerInfo
    
    var r: String!
    var s: String!
    var m: String!
    
    var dropDown = DropDown()
    
    let name = UserDefaults.standard.object(forKey: "playerName")

    var activity: NVActivityIndicatorView!
    
    override func viewWillAppear(_ animated: Bool) {
        LoadActivity()
        var dropperContent = [String]()
        for statistics in cellData {
            dropperContent.append(statistics.Region.uppercased())
        }
        
        dropperContent = dropperContent.uniqueElements
        
        self.overallStatsCollectionView.reloadData()
        self.activity.stopAnimating()
        
        SetupDropDown(DC: dropperContent)
        
        HandleDropDownSelections()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overallLabel.backgroundColor = DARK_GREY

        self.navigationItem.title = seasonTitle
    }
    
    func SetupDropDown(DC: [String]){

        let rightButtonItem = UIBarButtonItem.init(
            title: "\(DC[0]) ↓",
            style: .done,
            target: self,
            action: #selector(PreviousSeasonsVC.rightButtonTapped)
        )
        r = DC[0]
        stats.removeAll()
        for statistics in cellData {
            if statistics.Region == r.lowercased() {
                stats.append(statistics)
            }
        }
        self.navigationItem.rightBarButtonItem = rightButtonItem
        dropDown.dataSource = DC
        dropDown.anchorView = self.navigationItem.rightBarButtonItem
        overallStatsCollectionView.delegate = self
        self.overallStatsCollectionView.dataSource = self
    }
    
    func HandleDropDownSelections() {
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.LoadActivity()
            self?.navigationItem.rightBarButtonItem?.title = "\(item) ↓"
            self?.r = item
            self?.s = PUBGME.instance.ReturnSeasonHref(season: (self?.seasonTitle)!)
            self?.UpdateCells(cData: (self?.cellData)!)

        }
    }
    
    func UpdateCells(cData: [Stats]) {
        stats.removeAll()
        for stat in cData {
            if stat.Season == s, stat.Region == r.lowercased() {
                stats.append(stat)
            }
        }
        overallStatsCollectionView.reloadData()
        self.activity.stopAnimating()
    }
    
    func rightButtonTapped() {
        dropDown.show()
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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = stats[indexPath.row]
            if let cell = overallStatsCollectionView.dequeueReusableCell(withReuseIdentifier: "statisticsCell", for: indexPath) as? StatisticsCell {
                cell.ConfigureCell(stat: data)
                return cell
            }
        
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (collectionView.bounds.width - 30), height: 135)
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
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
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stats.count
    }
}
