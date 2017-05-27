//
//  tableViewCell.swift
//  IHPlayer
//
//  Created by Md Ibrahim Hassan on 21/05/17.
//  Copyright © 2017 Md Ibrahim Hassan. All rights reserved.
//

import UIKit

class tableViewCell12: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        songName.center.x = 0.0 // Place it in the center x of the view.
        // animate it from the left to the right
        /*UIView.animate(withDuration: 3.0, delay: 0, options: [.repeat], animations: {
            
            self.songName.center.x += self.frame.size.width
            self.layoutIfNeeded()
            
        }, completion: nil)*/
    }

    @IBOutlet weak var songName: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
