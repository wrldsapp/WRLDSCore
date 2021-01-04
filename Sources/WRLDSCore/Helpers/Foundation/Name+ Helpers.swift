//
//  ProcessMonitor.swift
//  WRLDS
//
//  Created by Garrett Jester on 8/31/20.
//  Copyright © 2020 WRLDS. All rights reserved.
//

import Foundation


public extension Notification.Name {
    
    static var processStarted: Notification.Name {
        return .init("processStarted")
    }
    
    static var processFinished: Notification.Name {
        return .init("processEnded")
    }
    
    static var pagingFinished: Notification.Name {
        return .init("pagingFinished")
    }
    
    static var musicPlayerPlaybackStarted: Notification.Name {
        return .init("musicPlayerPlaybackStarted")
    }
    
    static var musicPlayerPlaybackPaused: Notification.Name {
        return .init("musicPlayerPlaybackPaused")
    }
}
