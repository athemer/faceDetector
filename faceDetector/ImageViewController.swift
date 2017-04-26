//
//  ImageViewController.swift
//  faceDetector
//
//  Created by 陳冠華 on 2017/4/25.
//  Copyright © 2017年 my app. All rights reserved.
//

import UIKit
import CoreImage

class ImageViewController: UIViewController {
    

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        detect()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func detect() {
        
        guard let personciImage = CIImage(image: imageView.image!) else {
            return
        }
        
        let accuracy = [CIDetectorAccuracy: CIDetectorAccuracyHigh]
        let faceDetector = CIDetector(ofType: CIDetectorTypeFace, context: nil, options: accuracy)
        let faces = faceDetector?.features(in: personciImage)
        
        
        // 用來將 Core Image 座標轉換成 UIView 座標
        let ciImageSize = personciImage.extent.size
        var transform = CGAffineTransform(scaleX: 1, y: -1)
        transform = transform.translatedBy(x: 0, y: -ciImageSize.height)
        
        
        
        for face in faces as! [CIFaceFeature] {
            
            print("Found bounds are \(face.bounds)")
            
            
            // 套用座標轉換實作
            var faceViewBounds = face.bounds.applying(transform)
            
            // 計算矩形在 imageView 中的實際位置和大小
            let viewSize = imageView.bounds.size
            let scale = min(viewSize.width / ciImageSize.width,
                            viewSize.height / ciImageSize.height)
            let offsetX = (viewSize.width - ciImageSize.width * scale) / 2
            let offsetY = (viewSize.height - ciImageSize.height * scale) / 2
            
            faceViewBounds = faceViewBounds.applying(CGAffineTransform(scaleX: scale, y: scale))
            faceViewBounds.origin.x += offsetX
            faceViewBounds.origin.y += offsetY
            
            let faceBox = UIView(frame: faceViewBounds)
            
            
            faceBox.layer.borderWidth = 3
            faceBox.layer.borderColor = UIColor.red.cgColor
            faceBox.backgroundColor = UIColor.clear
            imageView.addSubview(faceBox)
            
            if face.hasLeftEyePosition {
                print("Left eye bounds are \(face.leftEyePosition)")
            }
            
            if face.hasRightEyePosition {
                print("Right eye bounds are \(face.rightEyePosition)")
            }
        }
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        
        guard let cameraVC = storyboard?.instantiateViewController(withIdentifier: "CameraViewController") as? CameraViewController else { return }
        navigationController?.pushViewController(cameraVC, animated: true)
        
    }

    @IBAction func toFilter(_ sender: Any) {
        
        guard let feedVC = storyboard?.instantiateViewController(withIdentifier: "FeedViewController") as? FeedViewController else { return }
        navigationController?.pushViewController(feedVC, animated: true)
        
    }

}
