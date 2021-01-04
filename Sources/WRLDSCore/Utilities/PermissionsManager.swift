//
//  DevicePermissions.swift
//  WRLDS
//
//  Created by Garrett Jester on 10/19/20.
//  Copyright © 2020 WRLDS. All rights reserved.
//

import Foundation
@_exported import Contacts
@_exported import UserNotifications
@_exported import Photos
@_exported import UIKit

/// A class to manage and request access to core device features
/// (camera, microphone, contacts, photo library, etc.)
public class PermissionsManager {
    
    var contactsStatus: AuthorizationStatus {
        return CNContactStore
            .authorizationStatus(for: .contacts)
            .authorizationStatus
    }
    
    var photosStatus: AuthorizationStatus {
        return PHPhotoLibrary
            .authorizationStatus()
            .authorizationStatus
    }
    
    
    /// Requests user permission to access built-in device functionality.
    /// - Parameters:
    ///   - type: The type of permission being requested.
    ///   - completion: A closure containing a boolean (true if access is given).
    func requestPermission(for type: DevicePermissionType, completion: @escaping(_ access:Bool) -> Void) {
        switch type {
        case .photoLibrary:
            requestPhotosAccess { (access) in completion(access) }
        case .contacts:
            requestContactsAccess { (access) in completion(access) }
        default:
            return
        }
    }
    
    
    /// Requests contacts access from the user.
    /// - Parameter completion: A closure called with (accessGranted),
    /// a Bool indicating whether the user granted access
    private func requestContactsAccess(_ completion: @escaping (_ accessGranted: Bool) -> Void)  {
        
        if self.contactsStatus == .denied {
            // User must permit access through settings.
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            return
        }
        // Request contacts access.
        CNContactStore().requestAccess(for: .contacts) { (access, _) in
            completion(access)
        }
    }
    
    
    /// Requests photos access from the user.
    /// - Parameter completion: A closure called with (accessGranted),
    /// a Bool indicating whether the user granted access
    private func requestPhotosAccess(_ completion: @escaping (_ accessGranted: Bool) -> Void) {
        if self.photosStatus == .denied {
            // User must permit access through settings.
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            return
        }
        
        PHPhotoLibrary.requestAuthorization { (status) in
            completion(status == .authorized)
        }
    }
}


enum DevicePermissionType {
    case contacts
    case camera
    case microphone
    case photoLibrary
}


enum AuthorizationStatus {
    case authorized
    case denied
    case notDetermined
}


extension CNAuthorizationStatus {
    
    var authorizationStatus: AuthorizationStatus {
        switch self {
        case .authorized:
            return .authorized
        case .denied:
            return .denied
        case .notDetermined:
            return .notDetermined
        default:
            fatalError("Uncaught authorization status.")
        }
    }
}


extension PHAuthorizationStatus {
    var authorizationStatus: AuthorizationStatus {
        switch self {
        case .authorized:
            return .authorized
        case .denied:
            return .denied
        case .notDetermined:
            return .notDetermined
        default:
            fatalError("Uncaught authorization status.")
        }
    }
}
