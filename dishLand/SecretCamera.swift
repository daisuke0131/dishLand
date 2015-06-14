//
//  SecretCamera.swift
//  dishLand
//
//  Created by 山本　恭大 on 2015/06/14.
//  Copyright (c) 2015年 daisuke. All rights reserved.
//

import UIKit
import AVFoundation

class SecretCamera: NSObject {
    
    var secretView : UIView!
    
    var stillImageOutput: AVCaptureStillImageOutput!
    var captureSession: AVCaptureSession!
    var videoconnection: AVCaptureConnection!
    
    func openTake()
    {
        //スクリーンの幅
        let screenWidth = UIScreen.mainScreen().bounds.size.width;
        //スクリーンの高さ
        let screenHeight = UIScreen.mainScreen().bounds.size.height;
        
        self.secretView = UIView(frame: CGRectMake(0.0, 0.0, screenWidth, screenHeight))
        
        configureCamera();
        takePhoto();
    }
    
    func configureCamera() -> Bool {
        // init camera device
        var captureDevice: AVCaptureDevice?
        var devices: NSArray = AVCaptureDevice.devices()
        
        // find back camera
        for device: AnyObject in devices {
            if device.position == AVCaptureDevicePosition.Front {
                captureDevice = device as? AVCaptureDevice
            }
        }
        
        if (captureDevice != nil) {
            // Debug
            println(captureDevice!.localizedName)
            println(captureDevice!.modelID)
        } else {
            println("Missing Camera")
            return false
        }
        
        var error: NSErrorPointer = nil
        var deviceInput: AVCaptureInput = AVCaptureDeviceInput.deviceInputWithDevice(captureDevice, error: error) as! AVCaptureInput
        
        self.stillImageOutput = AVCaptureStillImageOutput()
        
        // init session
        self.captureSession = AVCaptureSession()
        self.captureSession.sessionPreset = AVCaptureSessionPresetPhoto
        self.captureSession.addInput(deviceInput as AVCaptureInput)
        self.captureSession.addOutput(self.stillImageOutput)
        
        // layer for preview
        var previewLayer: AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer.layerWithSession(self.captureSession) as! AVCaptureVideoPreviewLayer
        previewLayer.frame = secretView.frame
        //self.view.layer.addSublayer(previewLayer)
        
        self.captureSession.startRunning()
        
        return true
    }
    
    func takePhoto(){
        if let stillOutput = self.stillImageOutput {
            //スレッドで安全に利用してクラッシュしないように
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                //ビデオコネクションを探す
                //self.videoconnection = AVCaptureConnection()!
                if let videoConnection = stillOutput.connectionWithMediaType(AVMediaTypeVideo){
                    self.stillImageOutput.captureStillImageAsynchronouslyFromConnection(videoConnection){
                        (imageSampleBuffer : CMSampleBuffer!, _) in
                        let imageDataJpeg = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageSampleBuffer)
                        var pickedImage: UIImage = UIImage(data: imageDataJpeg)!
                        UIImageWriteToSavedPhotosAlbum(pickedImage, nil, nil, nil)
                    }
                    self.captureSession.stopRunning()
                }
            }
        }
    }
}
