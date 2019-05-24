//
//  PostCell.swift
//  greekConnect
//
//  Created by Rohith Kasar on 5/7/19.
//  Copyright © 2019 rohith.kasar. All rights reserved.
//

import UIKit

protocol PostCellDelegate: class {
    func goingPressed(_ sender: UIButton)
    func interestedPressed(_ sender: UIButton)
    func notGoingPressed(_ sender: UIButton)
}

//class YourCell: UITableViewCell {
//
//    weak var delegate: PostCellDelegate?
//
//    @IBAction func buttonTapped(_ sender: UIButton) {
//        delegate?.didTapButton(sender)
//    }
//}

class PostCell: UITableViewCell {
    
    var delegate: PostCellDelegate?

    var going = false
    var interested = false
    var notGoing = false
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var orgNameLabel: UILabel!
    
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    @IBOutlet weak var goingButton: UIButton!
    @IBOutlet weak var interestedButton: UIButton!
    @IBOutlet weak var notGoingButton: UIButton!
//    @IBOutlet weak var goingCountLabel: UILabel!
//    @IBOutlet weak var interestedCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func goingPressed(_ sender: UIButton) {
        delegate?.goingPressed(sender)
    }

    @IBAction func notGoingPressed(_ sender: UIButton) {
        delegate?.notGoingPressed(sender)
    }
    @IBAction func interestedPressed(_ sender: UIButton) {
        delegate?.interestedPressed(sender)
    }
}
