//
//  PermissionManager.swift
//  CompraUSA
//
//  Created by Maria Eugênia Pereira Teixeira on 19/03/20.
//  Copyright © 2020 Maria Eugênia Pereira Teixeira. All rights reserved.
//

import UIKit
import AVFoundation
import Photos


enum PermissionType {
    case camera
    case photoLibrary
}

protocol PermissionDelegate {
    func updateCameraPermission(for granted: Bool)
    func updatePhotoLibraryPermission(for granted: Bool)
}

class PermissionsManager {
    
    var delegate: PermissionDelegate?
    
    func hasCameraPermission() -> Bool {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            return true
        case .notDetermined:
            askPermissionFor(type: .camera)
            return false
        default:
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: { _ in })
            }
            return false
        }
    }
    
    func hasPhotoLibraryPermission() -> Bool {
        switch PHPhotoLibrary.authorizationStatus() {
        case .authorized:
            return true
        case .notDetermined:
            askPermissionFor(type: .photoLibrary)
            return false
        default:
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: { _ in })
            }
            return false
        }
    }
    
    private func askPermissionFor(type: PermissionType) {
        switch type {
        case .camera:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                self.delegate?.updateCameraPermission(for: granted)
            }
        case .photoLibrary:
            PHPhotoLibrary.requestAuthorization({ status in
                self.delegate?.updatePhotoLibraryPermission(for: status == .authorized)
            })
        }
        
    }
    
}
