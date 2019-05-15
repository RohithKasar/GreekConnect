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
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var orgNameLabel: UILabel!
    
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var goingCountLabel: UILabel!
    @IBOutlet weak var interestedCountLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func goingPressed(_ sender: Any) {
    }
    
    @IBAction func notGoingPressed(_ sender: Any) {
    }
    @IBAction func interestedPressed(_ sender: Any) {
    }
}
