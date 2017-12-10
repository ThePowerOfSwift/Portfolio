//
//  MatchHistoryVC.swift
//  PUBGCompanion
//
//  Created by Kel Robertson on 1/09/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import LUExpandableTableView
import DropDown

class MatchHistoryVC: UIViewController {
    
    
    @IBOutlet weak var matchHistoryLabel: UILabel!
    
    @IBOutlet weak var matchHistoryTableView: LUExpandableTableView!
    
    var htmlData = PUBGTRACKER.instance.matchHistory
    var selectedSection: Int!

    override func viewWillAppear(_ animated: Bool) {
        matchHistoryTableView.register(UINib(nibName: "MatchHistoryHeaderView", bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: "matchHistoryHeader")
        matchHistoryTableView.expandableTableViewDataSource = self
        matchHistoryTableView.expandableTableViewDelegate = self
        matchHistoryTableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func SetupData(){


    }

}



extension MatchHistoryVC: LUExpandableTableViewDataSource {
    func numberOfSections(in expandableTableView: LUExpandableTableView) -> Int {
        return htmlData.count
    }
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let mHistory = htmlData[indexPath.section]
        if let cell = matchHistoryTableView.dequeueReusableCell(withIdentifier: "matchInfoCell", for: indexPath) as? MatchInfoCell {
            cell.ConfigureCell(match: mHistory)
            return cell
        }
        return UITableViewCell()
    }
    
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, sectionHeaderOfSection section: Int) -> LUExpandableTableViewSectionHeader {
        let mH = htmlData[section]
        if let header = matchHistoryTableView.dequeueReusableHeaderFooterView(withIdentifier: "matchHistoryHeader") as? MatchHistoryHeader {
            header.ConfigureCell(match: mH)
           header.isUserInteractionEnabled = true
            return header
        }
        return LUExpandableTableViewSectionHeader()
    }
}

// MARK: - LUExpandableTableViewDelegate

extension MatchHistoryVC: LUExpandableTableViewDelegate {
    func expandableTableView(_ expandableTableView: LUExpandableTableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        /// Returning `UITableViewAutomaticDimension` value on iOS 9 will cause reloading all cells due to an iOS 9 bug with automatic dimensions
        return 154.0
    }
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, heightForHeaderInSection section: Int) -> CGFloat {
        /// Returning `UITableViewAutomaticDimension` value on iOS 9 will cause reloading all cells due to an iOS 9 bug with automatic dimensions
        return 43.0
    }
    

    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, didSelectSectionHeader sectionHeader: LUExpandableTableViewSectionHeader, atSection section: Int) {
//        print("Did select cection header at section \(section)")
        if matchHistoryTableView.isExpandedSection(at: section){
             matchHistoryTableView.collapseSections(at: [section])
        } else {
            
            matchHistoryTableView.expandSections(at: [section])
            matchHistoryTableView.scrollToRow(at: IndexPath(row: 0, section: section), at: .middle, animated: true)
        }
        
    }

    func expandableTableView(_ expandableTableView: LUExpandableTableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        print("Will display cell at section \(indexPath.section) row \(indexPath.row)")
    }
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, willDisplaySectionHeader sectionHeader: LUExpandableTableViewSectionHeader, forSection section: Int) {
//        print("Will display section header for section \(section)")
    }
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, didSelectRowAt indexPath: IndexPath) {
//        print("Did select cell at section \(indexPath.section) row \(indexPath.row)")
    }
}
