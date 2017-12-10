//
//  ViewController.swift
//  KChat
//
//  Created by Kel Robertson on 6/01/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit
import FirebaseAuth

class CameraVC: CameraViewController{

    @IBOutlet weak var previewView: PreviewView!
    @IBOutlet weak var camButton: UIButton!
    @IBOutlet weak var recButton: UIButton!
    @IBOutlet weak var capModeControl: UISegmentedControl!
    @IBOutlet weak var camUnavailable: UILabel!
    @IBOutlet weak var livePhotoBtn: UIButton!
    @IBOutlet weak var photoBtn: UIButton!
    @IBOutlet weak var capLivePhotoLabel: UILabel!
    @IBOutlet weak var resumeBtn: UIButton!
    
    override func viewDidLoad() {

        // Connecting Apple Class CameraViewController
        
        _previewView = previewView
        _cameraButton = camButton
        _recordButton = recButton
        _captureModeControl = capModeControl
        _cameraUnavailableLabel = camUnavailable
        _photoButton = photoBtn
        _livePhotoModeButton = livePhotoBtn
        _capturingLivePhotoLabel = capLivePhotoLabel
        _resumeButton = resumeBtn
        
        super.viewDidLoad()
        
        if capModeControl.selectedSegmentIndex == 0 {
            recButton.isHidden = true
            photoBtn.isHidden = false
        } else if capModeControl.selectedSegmentIndex == 1 {
            recButton.isHidden = false
            photoBtn.isHidden = true
        }
        
    }


    @IBAction func recordBtnPressed(_ sender: AnyObject) {
       toggleMovieRecording()
    }
    @IBAction func changeCameraBtnPressed(_ sender: AnyObject) {
        changeCamera()
    }
    @IBAction func toggleMode(_ sender: AnyObject) {
        toggleCaptureMode()
    }
    @IBAction func livePhotoBtn(_ sender: AnyObject) {
        toggleLivePhotoMode()
    }
    @IBAction func photoBtnPressed(_ sender: AnyObject) {
        capturePhoto()
    }
    @IBAction func resumeButtonPressed(_ sender: AnyObject) {
        resumeInterruptedSession()
    }
    @IBAction func cancelMomentPressed(_ sender: AnyObject) {
        performSegue(withIdentifier: "cancelMoment", sender: nil)
    }
    


}

