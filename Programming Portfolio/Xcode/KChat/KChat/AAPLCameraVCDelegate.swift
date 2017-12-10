//
//  AAPLCameraVCDelegate.swift
//  KChat
//
//  Created by Kel Robertson on 6/01/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import Foundation

protocol AAPLCamerVCDelegate {
    func videoRecordingComplete(videoUrl: NSURL)
    func videoRecordingFailed()
    func snapShotTaken(snapshotData: Data)
    func snapshotFailed()
}
