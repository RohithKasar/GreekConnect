//
//  PostCell.swift
//  greekConnect
//
//  Created by Rohith Kasar on 5/7/19.
//  Copyright © 2019 rohith.kasar. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var orgLabel: UILabel!
    @IBOutlet weak var eventLabel: UILabel!
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    
    @IBOutlet weak var goingButton: UIButton!
    @IBOutlet weak var interestedButton: UIButton!
    @IBOutlet weak var notGoingButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
