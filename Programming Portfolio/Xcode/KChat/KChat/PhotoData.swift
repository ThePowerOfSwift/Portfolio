//
//  PhotoData.swift
//  KChat
//
//  Created by Kel Robertson on 18/01/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import Foundation

//Passes Photo Data From PhotoCapture Delegate to CameraViewController

struct PhotoData {
    
    static var _photoData: Data!
    
    var photoData: Data {
        return PhotoData._photoData
    }
    
    init (photoData: Data) {
        PhotoData._photoData = photoData
    }
    
}
