//
//  ArtworkImageView.swift
//  WRLDS
//
//  Created by Garrett Jester on 11/18/20.
//  Copyright © 2020 WRLDS. All rights reserved.
//

import UIKit
import SDWebImage

open class FetchableImageView: UIImageView {
    
    public var placeholder: UIImage?
    
    open var url: String? {
        didSet {
            if let string = url, let url = URL(string: string) {
                // Load profile image from URL
                self.sd_setImage(
                    with: url,
                    placeholderImage: placeholder ?? UIImage(color: .selectedCellBackground),
                    options: [],
                    completed: nil)
            } else {
                // This user doesn't have a profile image set.
                self.image = placeholder ?? UIImage(color: .selectedCellBackground)
            }
        }
    }
    
    public init() {
        super.init(frame: CGRect.zero)
        self.backgroundColor = .selectedCellBackground
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
