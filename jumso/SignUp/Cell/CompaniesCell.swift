//
//  CompaniesCell.swift
//  jumso
//
//  Created by junha on 9/23/24.
//

import UIKit

class CompaniesCell: UITableViewCell {
    
    @IBOutlet weak var companyNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        companyNameLabel.textColor = .black
        companyNameLabel.font = UIFont.systemFont(ofSize: 15)
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
