//
//  ShareControlVC.swift
//  PUBG Hub
//
//  Created by Kel Robertson on 7/10/17.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit
import Kanna

class ShareControlVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var shareControlCollectionView: UICollectionView!
    
    var htmlData: String! = PUBGME.instance._overallHTMLData
    var cellData = [ShareLinks]()
    var links = [String]()
    var modes = [String]()
    var regions = [String]()
    var seasons = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let doc = HTML(htmlData, encoding: .utf8) {
            for statLinks in doc.xpath("//div[@class='dropdown-menu dropdown-menu-compare dropdown-menu-profile-stats']/a[@class='dropdown-item d-flex']/@href"){
                let range1 = statLinks.text?.range(of: "?")
                let endStr = statLinks.text?.substring(from: (range1?.upperBound)!)
                let range2 = endStr?.range(of: "&")
                let season =  endStr?.substring(to: (range2?.lowerBound)!)
                let region = endStr?.substring(from: (range2?.upperBound)!)
                if let finalSeason = season?.replacingOccurrences(of: "season=", with: ""), let r = region?.replacingOccurrences(of: "region=", with: ""){
                    regions.append(r.uppercased())
                    seasons.append(PUBGME.instance.ReturnSeasonString(season: finalSeason))
                    links.append(statLinks.text!)
                }
            
            }
            
            for mode in doc.xpath("//div[@class='dropdown-menu dropdown-menu-compare dropdown-menu-profile-stats']/a[@class='dropdown-item d-flex']/span[1]/span[@class='match']") {
                modes.append(mode.text!)
            }
            
            for x in 0..<modes.count {
                let stat = ShareLinks(region: regions[x], season: seasons[x], mode: modes[x].uppercased(), link: links[x])
                cellData.append(stat)
            }
            self.shareControlCollectionView.delegate = self
            self.shareControlCollectionView.dataSource = self
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let singleLink = cellData[indexPath.row]
        if let cell = shareControlCollectionView.dequeueReusableCell(withReuseIdentifier: "shareCell", for: indexPath) as? ShareCell {
            cell.ConfigureCell(data: singleLink)
            return cell
        }
        return UICollectionViewCell()
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return links.count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCell = cellData[indexPath.row]
        performSegue(withIdentifier: "showStatsShare", sender: selectedCell)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showStatsShare" {

        }
    }
}
