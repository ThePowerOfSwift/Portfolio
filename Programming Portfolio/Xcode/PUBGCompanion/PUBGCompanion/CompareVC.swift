//
//  CompareVC.swift
//  PUBG Hub
//
//  Created by Kel Robertson on 17/11/17.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit
import SwiftyJSON

class CompareVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var playerOneTV: UITableView!
    @IBOutlet weak var playerTwoTV: UITableView!
    
    @IBOutlet weak var playerOneName: UILabel!
    @IBOutlet weak var playerTwoName: UILabel!
    

    var playerOneInfo = PUBGTRACKER.instance.playerInfo
    var playerTwoInfo = PUBGTRACKER.instance.searchPlayerInfo
    var p1 = PUBGTRACKER.instance.aggStats
    var p2 = PUBGTRACKER.instance.aggSearchStats
    
    var statsData = [Int:[String:Any]]()
    
    override func viewWillAppear(_ animated: Bool) {
        playerOneName.text = playerOneInfo?.playerName
        playerTwoName.text = playerTwoInfo?.playerName
        PUBGTRACKER.instance.CompareData(data: p1)
        self.playerOneTV.delegate = self
        self.playerOneTV.dataSource = self
        self.playerTwoTV.delegate = self
        self.playerTwoTV.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == playerOneTV {
//            return statsData[0]!.count
        } else {
//            return statsData[1]!.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if tableView == playerOneTV {
//            let stat = p1[indexPath.row]
//            if let cell = playerOneTV.dequeueReusableCell(withIdentifier: "compareCell", for: indexPath) as? CompareCell {
//            
//                cell.ConfigureCell(stat: stat)
//                return cell
//            }
//        } else {
//            let stat = p2[indexPath.row]
//            if let cell = playerTwoTV.dequeueReusableCell(withIdentifier: "compareCell", for: indexPath) as? CompareCell {
//                cell.ConfigureCell(stat: stat)
//                return cell
//            }
//        }

        return CompareCell()
    }
}
