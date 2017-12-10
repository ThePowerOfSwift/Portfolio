//
//  ViewVideoVC.swift
//  PUBGCompanion
//
//  Created by Kel Robertson on 31/08/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit
import YouTubePlayer
import NVActivityIndicatorView

class ViewVideoVC: UIViewController, YouTubePlayerDelegate{

    @IBOutlet weak var videoPlayer: YouTubePlayerView!
    
    var videoID: String!
    
    override func viewWillAppear(_ animated: Bool) {
        let frameForPlayer = self.view.frame
        
        let player = YouTubePlayerView(frame: frameForPlayer)
        
        player.loadVideoID(videoID)
        
        self.view.addSubview(player)
        
        player.delegate = self
        
        self.updateViewConstraints()
    }
    func playerReady(_ videoPlayer: YouTubePlayerView) {
        if videoPlayer.ready {
            videoPlayer.play()
        }
        
    }
    func playerStateChanged(_ videoPlayer: YouTubePlayerView, playerState: YouTubePlayerState) {
        if playerState == .Ended {
            self.view.willRemoveSubview(videoPlayer)
        } else if playerState == .Playing {
            let button = UIButton(frame: CGRect(x: self.view.center.x - 40, y: self.view.center.y + 150, width: 80, height: 30))
            button.backgroundColor = UIColor.red
            button.layer.cornerRadius = 5
            button.setTitle("Close",for: .normal)
            button.tintColor = DARK_GREY
            button.addTarget(self, action: #selector(DismissView), for: .touchUpInside)
            self.view.addSubview(button)
        } else if playerState == .Unstarted {
            let alert = UIAlertController(title: "YouTube Error", message: "This video contains content unavliable in your region", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.destructive, handler: { action in
                self.DismissView()
            }))
            self.present(alert, animated: true, completion:nil)
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.layoutSubviews()
        self.updateViewConstraints()
    }
    func DismissView(){
        self.dismiss(animated: true, completion: nil)
    }
}
