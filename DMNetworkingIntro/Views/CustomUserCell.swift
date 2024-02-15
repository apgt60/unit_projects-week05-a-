//
//  CustomUserCell.swift
//  DMNetworkingIntro
//
//  Created by Amit Patel on 2/15/24.
//

import UIKit

class CustomUserCell: UITableViewCell {
    
    @IBOutlet weak var customUserCell: UIView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
