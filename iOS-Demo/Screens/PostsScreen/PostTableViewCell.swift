//
//  PostTableViewCell.swift
//  iOS-Demo
//
//  Created by Enrique Bermúdez on 2/2/19.
//  Copyright © 2019 Enrique Bermudez. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet private weak var postTitleLabel: UILabel!
    
    func setPost(_ post: Post) {
        self.postTitleLabel.text = post.title
    }
    
}
