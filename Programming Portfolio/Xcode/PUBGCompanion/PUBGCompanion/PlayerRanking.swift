//
//  PlayerRanking.swift
//  PUBGCompanion
//
//  Created by Kel Robertson on 9/09/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import Foundation

struct PlayerRank {
    
    var _place: String!
    var _imgSrc: String!
    var _playerName: String!
    
    var place: String {
        return _place
    }
    var playerName: String { 
        return _playerName
    }
    var imgSrc: String {
        return _imgSrc
    }
}

struct LeaderBoardStats {
      var ratingLabel: String!
      var ratingValue: String!
      var rankLabel: String!
      var rankValue: String!
      var matchesPlayedLabel: String!
      var matchesPlayedValue: String!
      var winRateLabel: String!
      var winRateValue: String!
      var winsLabel: String!
      var winsValue: String!
      var kdLabel: String!
      var kdValue: String!
      var killsLabel: String!
      var killsValue: String!
      var avgDmgPerMLabel: String!
      var avgDmgPerMValue: String!
      var cellTitle: String!
}
