//
//  MatchHistoryVC2.swift
//  PUBG Hub
//
//  Created by Kel Robertson on 22/10/17.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit
import Kanna
class MatchHistoryVC2: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var matchHistoryTV: UITableView!
    
    var htmlData = PUBGTRACKER.instance.matchHistory
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        SetupData()
    }
    
    func SetupData(){
        PUBGTRACKER.instance.PlayerData(name: "kellogs") { (suc, msg) in
            if(suc)!{
                self.matchHistoryTV.dataSource = self
                self.matchHistoryTV.delegate = self
                self.matchHistoryTV.reloadData()
                
            }
        }

        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let d = htmlData[indexPath.row]
        if let cell = matchHistoryTV.dequeueReusableCell(withIdentifier: "matchHistory2", for: indexPath) as? MatchHistoryCell {
            cell.ConfigureCell(match: d)
            if cell.extraData == true {
                cell.accessoryType = .disclosureIndicator
                cell.isUserInteractionEnabled = true
            } else {
                cell.accessoryType = .none
                cell.isUserInteractionEnabled = false
            }
            return cell
        }
        return UITableViewCell()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return htmlData.count
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let selectedCell = htmlData[indexPath.row]
//        if let doc = HTML(selectedCell, encoding: .utf8) {
//            if let link = doc.xpath("//a[@class='cover-link']/@href").first {
//                let uppRange = link.text?.range(of: "/")
//                let id = link.text?.substring(from: (uppRange?.upperBound)!)
//                performSegue(withIdentifier: "matchHistoryShare", sender: id)
//            }
//        }
//
//
//    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "matchHistoryShare" {
            if let destination = segue.destination as? MatchHistoryShareVC {
                destination.id = sender as! String
            }
        }
    }
}
