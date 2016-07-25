//
//  CustomOverlayView.swift
//  CustomOverlay
//
//  Created by Adela Gao on 7/24/16.
//  Copyright © 2016 Adela Gao. All rights reserved.
//

import UIKit

protocol CustomOverlayDelegate{
    func didCancel(overlayView:CustomOverlayView)
    func didShoot(overlayView:CustomOverlayView)
}

class CustomOverlayView: UIView {
    
    var delegate:CustomOverlayDelegate!
    weak var picker: UIImagePickerController? {
        didSet {
            if let picker = picker {
                picker.sourceType = .Camera
                picker.showsCameraControls = false
                adjustPreviewHeight()
                if UIImagePickerController.isCameraDeviceAvailable(.Front) {
                    picker.cameraDevice = .Front
                }
            }
        }
    }

    @IBAction func cancelButtonTapped(sender: UIButton) {
        delegate.didCancel(self)
    }
    
    @IBAction func shootButtonTapped(sender: UIButton) {
        delegate.didShoot(self)
    }
    
    @IBAction func flashButtonTapped(sender: UIButton) {
        if let flashState = picker?.cameraFlashMode {
            switch flashState {
            case .On:
                picker?.cameraFlashMode = .Off
            case .Off:
                picker?.cameraFlashMode = .Auto
            case .Auto:
                picker?.cameraFlashMode = .On
            }
        }
    }
    
    func adjustPreviewHeight() {
        let topBarHeight = CGFloat(100) // Change it based on your view
        if let picker = picker {
            picker.cameraViewTransform = CGAffineTransformTranslate(picker.cameraViewTransform, 0.0, topBarHeight)
        }
    }
    
}
