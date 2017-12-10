//
//  SentMoments.swift
//  KChat
//
//  Created by Kel Robertson on 13/01/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit
import Firebase
import AVKit
import AVFoundation

class SentMomentsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var momentTableView: UITableView!
    var recievedMessageKeys = Dictionary<String,AnyObject>()
    var moments = [Moment]()
    var sentCount = 0
    var count = 0
    static var sentImageCache: NSCache<NSString, UIImage> = NSCache()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.momentTableView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.showLoadingView(message: "Loading...", disableUI: true)
        DispatchQueue.global(qos: .background).async {
            if self.sentCount == 0 {
                DispatchQueue.main.async {
                    self.hideLoadingViewBasic(animated: true)
                    self.NotificationBanner(title: "No Moments", message: "There are no sent moments to display")
                    
                }
                self.momentTableView.dataSource = self
            } else {
                if self.sentCount != self.moments.count {
                    self.moments = []
                    DataService.instance.observeSentMessages(onComplete: { (success, message, data) in
                        if success == true {
                            self.moments.append(data!)
                            StorageService.instance.downloadSentMomentImages(moment: data!) { (success, msg, images) in
                                
                                DispatchQueue.main.async {
                                    self.count += 1
                                    self.momentTableView.dataSource = self
                                    self.momentTableView.reloadData()
                                    
                                    if self.count == self.sentCount {
                                        
                                        self.hideLoadingViewBasic(animated: true)
                                    }
                                    
                                }
                            }
                        }
                        
                    })
                } else {
                    DispatchQueue.main.async {
                        self.momentTableView.dataSource = self
                        self.momentTableView.reloadData()
                        
                        if self.count == self.sentCount {
                            
                            self.hideLoadingViewBasic(animated: true)
                        }
                        
                    }
                }
            }
        }
       
  
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let moment = moments[indexPath.row]
        if let cell = momentTableView.dequeueReusableCell(withIdentifier: "sentMomentCell", for: indexPath) as? SentMomentCell {
            cell.configureCell(moment: moment)
            return cell
        }
        return UITableViewCell()
    }

    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moments.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellSelected = moments[indexPath.row]
        
        if cellSelected._momentType == "Video" {
            performSegue(withIdentifier: "sentMomentVideo", sender: cellSelected._previewImage)
        } else if cellSelected._momentType == "Photo" {
            performSegue(withIdentifier: "sentMomentPhoto", sender: cellSelected)
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sentMomentVideo" {
            let destinationVideo = segue.destination as! AVPlayerViewController
            let url = URL(string: sender as! String)
            print("KEL: \(url)")
            if let movieURL = url {
                destinationVideo.player = AVPlayer(url: movieURL)
            }
            
        } else if segue.identifier == "sentMomentPhoto" {
            if let destinationPhoto = segue.destination as? MomentImageViewVC {
                if let moment = sender as? Moment {
                    destinationPhoto.moment = moment
                    destinationPhoto.momentType = "sent"
                    
                }
            }
            
        }
    }
    
    @IBAction func backBtnPressed(_ sender: AnyObject) {
        
    }

    @IBAction func UnwindToSentMoments(segue: UIStoryboardSegue){
    }
}
