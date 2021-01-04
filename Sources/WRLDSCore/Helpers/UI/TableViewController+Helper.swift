//
//  UITableViewController+Helper.swift
//  WRLDS
//
//  Created by Garrett Jester on 11/19/20.
//  Copyright © 2020 WRLDS. All rights reserved.
//

import UIKit

/// From 'mpvosseller' on Github: https://gist.github.com/alexmx/3bd217b25542fc3dd41fa79cfe2a22c7

public extension UITableViewController {
    
    func adjustFooterViewHeightToFillTableView() {
        
        // Invoke from UITableViewController.viewDidLayoutSubviews()
        
        if let tableFooterView = self.tableView.tableFooterView {
            
            let minHeight = tableFooterView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
            let currentFooterHeight = tableFooterView.frame.height
    
            let fitHeight = self.tableView.frame.height - self.tableView.adjustedContentInset.top - self.tableView.contentSize.height  + currentFooterHeight
            
            let nextHeight = (fitHeight > minHeight) ? fitHeight : minHeight
            
            if (round(nextHeight) != round(currentFooterHeight)) {
                var frame = tableFooterView.frame
                frame.size.height = nextHeight
                tableFooterView.frame = frame
                self.tableView.tableFooterView = tableFooterView
            }
        }
    }
}
