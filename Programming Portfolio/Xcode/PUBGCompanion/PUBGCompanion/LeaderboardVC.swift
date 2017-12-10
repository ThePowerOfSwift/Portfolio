//
//  LeaderboardVC.swift
//  PUBGCompanion
//
//  Created by Kel Robertson on 9/09/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit
import DropDown
import Alamofire
import Kanna
import SwiftyJSON
import NVActivityIndicatorView
import  SDWebImage

class LeaderboardVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var webScrapper: UIWebView!
    @IBOutlet weak var rankingTableView: UITableView!
    
    @IBOutlet weak var adviceLabel: UILabel!
    @IBOutlet weak var dropdownView: UIView!
    
    var seasonsFiler = ["2017-pre1","2017-pre2","2017-pre3","2017-pre4", "2017-pre5"]
    var seasons = ["Season 1", "Season 2", "Season 3", "Season 4","Season 5"]
    var gameTypesFilter = ["solo","duo","squad","solo-fpp", "duo-fpp", "squad-fpp"]
    var gameTypes = ["Solo","Duo","Squad", "Solo-FPP", "Duo-FPP", "Squad-FPP"]
    var regionsFiler = ["na","sa","eu","oc","as","sea"]
    var regions = ["NA","SA","EU","OC","AS","SEA"]
    
    var s: String!
    var r: String!
    var m: String!
    
    let seasonDropDown = DropDown()
    let regionDropDown = DropDown()
    let modeDropDown = DropDown()
    
    @IBOutlet weak var seasonButton: UIButton!
    @IBOutlet weak var regionButton: UIButton!
    @IBOutlet weak var modeButton: UIButton!
    @IBOutlet weak var goButton: UIButton!
    
    var playerNames = [String]()
    var playerPlaces = [String]()
    var playerImgSrcs = [String]()
    
    var playerData = [Int:PlayerRank]()
    var playerImg: UIImage!
    
    var activity:NVActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adviceLabel.isHidden = false
        SetupFilterButtons()
        rankingTableView.delegate = self
        rankingTableView.dataSource = self
    }
    
    func SetupFilterButtons() {
        goButton.layer.cornerRadius = 5
        
        seasonDropDown.anchorView = seasonButton.titleLabel?.plainView
        seasonDropDown.dataSource = seasons
        
        regionDropDown.anchorView = regionButton.titleLabel?.plainView
        regionDropDown.dataSource = regions
        
        modeDropDown.anchorView = modeButton.titleLabel?.plainView
        modeDropDown.dataSource = gameTypes
        
        seasonDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.seasonButton.setTitle("\(self.seasons[index])",for: .normal)
            self.s = self.seasonsFiler[index]

        }
        regionDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.regionButton.setTitle("\(self.regions[index])",for: .normal)
            self.r = self.regionsFiler[index]

        }
        modeDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.modeButton.setTitle("\(self.gameTypes[index])",for: .normal)
            self.m = self.gameTypesFilter[index]


        }
        
    }
    
    func ScrapeWebData(season:String,region:String,mode:String){
        let url = URL(string: "\(NODEBASEURL)/Leaderboards/\(season)/\(region)/\(mode)")
        let urlRequest = URLRequest(url: url!)
        Alamofire.request(urlRequest).responseString(encoding: String.Encoding.utf8) { (htmlData) in
            if let d = htmlData.result.value {
                self.ParseHTML(data: d)
            }else {
               
            }
            
        }
    }
    
    func ParseHTML(data:String){
        if let doc = HTML(data, encoding: .utf8) {
            for playerName in doc.xpath("//div[@class='sidebar-user-name']") {
                let dataSource = playerName.innerHTML!
                let strData = dataSource.replacingOccurrences(of: "\n", with: "")
                playerNames.append(strData)
            }
            for playerImg in doc.xpath("//a[@class='sidebar-user-link']//img/@src"){
                let dataSource = playerImg.innerHTML!
                let strippedData = dataSource.replacingOccurrences(of: "src=", with: "")
                let finalData = strippedData.replacingOccurrences(of: "\"", with: "")
                let final = finalData.replacingOccurrences(of: " ", with: "")
                playerImgSrcs.append(final)
         
            }
            for place in doc.xpath("//td[@class='td-32']"){
                playerPlaces.append(place.innerHTML!)
            }
            for x in 0..<playerNames.count {
                playerData[x] = PlayerRank(_place: playerPlaces[x], _imgSrc: playerImgSrcs[x], _playerName: playerNames[x])
            }
            adviceLabel.isHidden = true
            if (self.playerNames == []){
                adviceLabel.isHidden = false
                self.adviceLabel.text = "No Game Data Exists for the selection."
            }
            DispatchQueue.main.async {

                self.rankingTableView.reloadData()
                self.activity.stopAnimating()
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let player = playerData[indexPath.row] {
            if let rankCell = rankingTableView.dequeueReusableCell(withIdentifier: "userRankCell", for: indexPath) as? UserRankCell {
                rankCell.configureCell(data: player)
                DispatchQueue.global(qos: .background).async {
                    rankCell.avatarImg.sd_setImage(with: URL(string:player._imgSrc), completed: { (image, err, imageCache, u) in})
                }
                return rankCell
            }
        }
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playerData.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        activity.startAnimating()
        if let player = playerData[indexPath.row] {
            PUBGTRACKER.instance.SerachPlayerData(name: player._playerName, completed: { (success, msg) in
                if (success)! {
                    self.performSegue(withIdentifier: "showLeaderStats", sender: player)
                    self.activity.stopAnimating()
                }
            })
            }
        
    }

    @IBAction func SeasonPressed(_ sender: Any) {
        seasonDropDown.show()
    }
    @IBAction func RegionPressed(_ sender: Any) {
        regionDropDown.show()
    }
    
    @IBAction func ModePressed(_ sender: Any) {
        modeDropDown.show()
    }
    
    @IBAction func GoButtonPressed(_ sender: Any) {
        if (s == nil || r == nil || m == nil){
            adviceLabel.text = "Please make sure you have selected a Season, Regin and Mode, before pressing GO"
        }else{
            playerNames.removeAll()
            playerPlaces.removeAll()
            playerImgSrcs.removeAll()
            playerData.removeAll()
            self.ScrapeWebData(season: s, region: r, mode: m)
            LoadActivity()
        }
    }
}
