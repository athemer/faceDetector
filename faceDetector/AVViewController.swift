//
//  AVViewController.swift
//  faceDetector
//
//  Created by 陳冠華 on 2017/4/26.
//  Copyright © 2017年 my app. All rights reserved.
//

import UIKit
import AVFoundation

class AVViewController: UIViewController {

    
    let session = AVCaptureSession()
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func meta() {
        var metadataOutput = AVCaptureMetadataOutput()
        metadataOutput.setMetadataObjectsDelegate(self as! AVCaptureMetadataOutputObjectsDelegate, queue: self.sessionQueue)
        if session.canAddOutput(metadataOutput) {
            session.addOutput(metadataOutput)
        }
        metadataOutput.metadataObjectTypes = [AVMetadataObjectTypeFace]
        
    }
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        for metadataObject in metadataObjects as! [AVMetadataObject] {
            if metadataObject.type == AVMetadataObjectTypeFace {
                var transformedMetadataObject = previewLayer.transformedMetadataObjectForMetadataObject(metadataObject)
            }
        }
    }
}
