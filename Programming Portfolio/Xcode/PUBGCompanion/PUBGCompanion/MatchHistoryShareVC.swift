//
//  MatchHistoryShareVC.swift
//  PUBG Hub
//
//  Created by Kel Robertson on 22/10/17.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit
import Kanna
import FBSDKLoginKit
import FBSDKShareKit
import NVActivityIndicatorView

class MatchHistoryShareVC: UIViewController {

    @IBOutlet weak var viewToImage: UIView!
    var id: String!
    var activity: NVActivityIndicatorView!
    @IBOutlet weak var playerImage: UIImageView!
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var shareLabel: UILabel!
    @IBOutlet weak var lastUpdated: UILabel!

    @IBOutlet weak var kills: UILabel!
    @IBOutlet weak var heals: UILabel!
    @IBOutlet weak var timeAlive: UILabel!
    @IBOutlet weak var assists: UILabel!
    @IBOutlet weak var boosts: UILabel!
    @IBOutlet weak var game: UILabel!
    @IBOutlet weak var damage: UILabel!
    @IBOutlet weak var weapons: UILabel!
    @IBOutlet weak var season: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var winRating: UILabel!
    @IBOutlet weak var killRating: UILabel!
    @IBOutlet weak var rank: UILabel!
    @IBOutlet weak var killRank: UILabel!
    @IBOutlet weak var winRank: UILabel!
    @IBOutlet weak var travelDist: UILabel!
    @IBOutlet weak var walkDist: UILabel!
    @IBOutlet weak var vehicleDist: UILabel!
    @IBOutlet weak var headshotKills: UILabel!
    @IBOutlet weak var roadKills: UILabel!
    @IBOutlet weak var vehiclesDestroyed: UILabel!
    @IBOutlet weak var dbno: UILabel!
    @IBOutlet weak var teamKills: UILabel!
    @IBOutlet weak var revives: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.global(qos: .background).async {
            PUBGME.instance.PubgmeMatchHistoryShareStats(ID: self.id, completed: { (success, msg, data) in
                if (success)! {
                    self.ParseHtml(data: data as! String)
                }
            })
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.view.backgroundColor = DARK_GREY
        self.viewToImage.isHidden = true
        LoadActivity()
        
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.titleView = nil
    }
    
    func ParseHtml(data:String!){
        if let doc = HTML(data, encoding: .utf8) {
            PUBGME.instance.ParseUserImage(data: data, completed: { (success, msg, data) in
                
                if (success)! {

                    self.playerImage.image = data as? UIImage
                    self.playerImage.clipsToBounds = true
                    self.playerImage.layer.cornerRadius = 20
                    self.viewToImage.isHidden = false
                    DispatchQueue.main.async {
                        
                        let image = UIImage.init(view: self.viewToImage)
                        let photo:FBSDKSharePhoto = FBSDKSharePhoto()
                        photo.image = image
                        photo.isUserGenerated = true
                        let content:FBSDKSharePhotoContent = FBSDKSharePhotoContent()
                        content.photos = [photo]
                        let shareButton = FBSDKShareButton()
                        shareButton.shareContent = content
                        self.navigationController?.navigationBar.topItem?.titleView = shareButton
                        shareButton.center = (self.navigationController?.navigationBar.center)!
                        self.activity.stopAnimating()
                        if shareButton.isEnabled == false {
                            let alert = UIAlertController(title: "Facebook Error", message: "Facebook must be installed for sharing to work.", preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.destructive, handler: { action in
                                self.DismissView()
                            }))
                            self.present(alert, animated: true, completion:nil)
                        }
                    }
                }
                
                
            })
            
            playerName.text = UserDefaults.standard.string(forKey: "playerName")
            for matchResult in doc.xpath("//div[contains(@class,'result')]/span") {
                shareLabel.text = matchResult.text!
                if let mR = matchResult.text {
                    switch mR {
                    case "DIED":
                        shareLabel.textColor = RED
                        break
                    case "WINNER WINNER CHICKEN DINNER!":
                        shareLabel.textColor = Y_ORANGE
                        break
                    case "MADE IT TO TOP 10!":
                        shareLabel.textColor = BLUE
                        break
                    default:
                        break
                    }
                }

            }
            for lastU in doc.xpath("//div[@class='last-updated']") {
                lastUpdated.text = lastU.text!
            }

            for h in doc.xpath("//div[@class='col-md-4'][2]/div[@class='stat stat-large']/div[@class='value']") {
                heals.text = h.text!
            }
            for tAlive in doc.xpath("//div[@class='col-md-4'][3]/div[@class='stat stat-large']/div[@class='value']") {
                timeAlive.text = tAlive.text!
            }
            for g in doc.xpath("//div[@class='card mb-3'][1]/div[@class='card-block profile-stats-page match-report-page profile-match-overview-undefined']/div[@class='row']/div[@class='col-md-4'][3]/div[@class='stat'][1]/div[@class='value']") {
                game.text = g.text!
            }
            for d in doc.xpath("//div[@class='card mb-3'][1]/div[@class='card-block profile-stats-page match-report-page profile-match-overview-undefined']/div[@class='row']/div[@class='col-md-4'][1]/div[@class='stat'][2]/div[@class='value']") {
                damage.text = d.text!
            }
            for w in doc.xpath("//div[@class='card mb-3'][1]/div[@class='card-block profile-stats-page match-report-page profile-match-overview-undefined']/div[@class='row']/div[@class='col-md-4'][2]/div[@class='stat'][2]/div[@class='value']") {
                weapons.text = w.text!
            }
            for s in doc.xpath("//div[@class='card mb-3'][1]/div[@class='card-block profile-stats-page match-report-page profile-match-overview-undefined']/div[@class='row']/div[@class='col-md-4'][3]/div[@class='stat'][2]/div[@class='value']") {
                let sea = PUBGME.instance.eaStrChange(earlyAccess: s.text!.capitalized)
                season.text = sea
            }
            for rate in doc.xpath("//div[@class='card mb-3'][2]/div[@class='card-block profile-stats-page match-report-page profile-match-overview-undefined']/div[@class='row']/div[@class='col-md-4'][1]/div[@class='stat'][1]/div[@class='value']/span[@class='value-new']") {
                rating.text = rate.text!
            }
            for wR in doc.xpath("//div[@class='card mb-3'][2]/div[@class='card-block profile-stats-page match-report-page profile-match-overview-undefined']/div[@class='row']/div[@class='col-md-4'][2]/div[@class='stat'][1]/div[@class='value']/span[@class='value-new']") {
                winRating.text = wR.text!
            }
            for kR in doc.xpath("//div[@class='card mb-3'][2]/div[@class='card-block profile-stats-page match-report-page profile-match-overview-undefined']/div[@class='row']/div[@class='col-md-4'][3]/div[@class='stat'][1]/div[@class='value']/span[@class='value-new']") {
                killRating.text = kR.text!
            }
            
            for r in doc.xpath("//div[@class='col-md-4'][1]/div[@class='stat'][2]/div[@class='value']/span[@class='value-new']") {
                rank.text = r.text!
            }

            for winR in doc.xpath("//div[@class='card mb-3'][2]/div[@class='card-block profile-stats-page match-report-page profile-match-overview-undefined']/div[@class='row']/div[@class='col-md-4'][2]/div[@class='stat'][2]/div[@class='value']/span[@class='value-new']") {
                winRank.text = winR.text!
            }

            for k in doc.xpath("//div[@class='col-md-4'][1]/div[@class='stat stat-large stat-red']/div[@class='value value-red']") {
                kills.text = k.text!
            }
            for killR in doc.xpath("//div[@class='card mb-3'][2]/div[@class='card-block profile-stats-page match-report-page profile-match-overview-undefined']/div[@class='row']/div[@class='col-md-4'][3]/div[@class='stat'][2]/div[@class='value']/span[@class='value-new']") {
                killRank.text = killR.text!
            }
            
            for vD in doc.xpath("//div[@class='card mb-3'][4]/div[@class='card-block profile-stats-page match-report-page profile-match-overview-undefined']/div[@class='row']/div[@class='col-md-4'][3]/div[@class='stat'][1]/div[@class='value']") {
                vehiclesDestroyed.text = vD.text!
            }

            for r in doc.xpath("//div[@class='card mb-3'][4]/div[@class='card-block profile-stats-page match-report-page profile-match-overview-undefined']/div[@class='row']/div[@class='col-md-4'][3]/div[@class='stat'][2]/div[@class='value']") {
                revives.text = r.text!
            }

            for a in doc.xpath("//div[@class='card mb-3'][1]/div[@class='card-block profile-stats-page match-report-page profile-match-overview-undefined']/div[@class='row']/div[@class='col-md-4'][1]/div[@class='stat'][1]/div[@class='value']") {
                assists.text = a.text!
            }


            for rK in doc.xpath("//div[@class='card mb-3'][4]/div[@class='card-block profile-stats-page match-report-page profile-match-overview-undefined']/div[@class='row']/div[@class='col-md-4'][2]/div[@class='stat'][1]/div[@class='value']") {
                roadKills.text = rK.text!
            }
            for tD in doc.xpath("//div[@class='card mb-3'][3]/div[@class='card-block profile-stats-page match-report-page profile-match-overview-undefined']/div[@class='row']/div[@class='col-md-4'][1]/div[@class='stat']/div[@class='value']") {
                travelDist.text = tD.text!
            }
            for wD in doc.xpath("//div[@class='card mb-3'][3]/div[@class='card-block profile-stats-page match-report-page profile-match-overview-undefined']/div[@class='row']/div[@class='col-md-4'][2]/div[@class='stat']/div[@class='value']/span[@class='value-new']") {
                walkDist.text = wD.text!
            }
            for vD in doc.xpath("//div[@class='card mb-3'][3]/div[@class='card-block profile-stats-page match-report-page profile-match-overview-undefined']/div[@class='row']/div[@class='col-md-4'][3]/div[@class='stat']/div[@class='value']/span[@class='value-new']") {
                vehicleDist.text = vD.text!
            }
            for dBNO in doc.xpath("//div[@class='card mb-3'][4]/div[@class='card-block profile-stats-page match-report-page profile-match-overview-undefined']/div[@class='row']/div[@class='col-md-4'][1]/div[@class='stat'][2]/div[@class='value']") {
                dbno.text = dBNO.text!
            }
            for tK in doc.xpath("//div[@class='card mb-3'][4]/div[@class='card-block profile-stats-page match-report-page profile-match-overview-undefined']/div[@class='row']/div[@class='col-md-4'][2]/div[@class='stat'][2]/div[@class='value']") {
                teamKills.text = tK.text!
            }
            for hsK in doc.xpath("//div[@class='card mb-3'][4]/div[@class='card-block profile-stats-page match-report-page profile-match-overview-undefined']/div[@class='row']/div[@class='col-md-4'][1]/div[@class='stat'][1]/div[@class='value']/span[@class='value-new']") {
                headshotKills.text = hsK.text!
            }
            
        }
    }
    
    func hideLabels() {
        playerImage.isHidden = true
        playerName.isHidden = true
        shareLabel.isHidden = true
        lastUpdated.isHidden = true
        rank.isHidden = true
        winRank.isHidden = true
        kills.isHidden = true
        killRank.isHidden = true
        assists.isHidden = true
        vehiclesDestroyed.isHidden = true
        roadKills.isHidden = true
        revives.isHidden = true
        dbno.isHidden = true
    }
    func unHideLabels() {
        playerImage.isHidden = false
        playerName.isHidden = false
        shareLabel.isHidden = false
        lastUpdated.isHidden = false
        rank.isHidden = false
        winRank.isHidden = false
        kills.isHidden = false
        killRank.isHidden = false
        assists.isHidden = false
        vehiclesDestroyed.isHidden = false
        roadKills.isHidden = false
        revives.isHidden = false
        dbno.isHidden = false

    }
    func DismissView(){
        self.dismiss(animated: true, completion: nil)
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
