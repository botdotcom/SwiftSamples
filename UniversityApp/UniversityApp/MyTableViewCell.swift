//
//  MyTableViewCell.swift
//  UniversityApp
//
//  Created by Shamli on 10/20/17.
//  Copyright © 2017 Atos. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var studentId: UILabel!
    @IBOutlet weak var studentName: UILabel!    
    @IBOutlet weak var studentPercent: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
