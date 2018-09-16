//
//  MainTableViewCell.swift
//  LiterateDisco
//
//  Created by Nathan Wainwright on 2018-09-12.
//  Copyright © 2018 Nathan Wainwright. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
  
  @IBOutlet weak var quoteLabel: UILabel!
  @IBOutlet weak var authorLabel: UILabel!
  @IBOutlet weak var quoteImage: UIImageView!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
