//
//  HomeLandingTableViewCell.swift
//  RakutenTest
//
//  Created by rajeshkumar.maurya on 9/10/21.
//

import UIKit

class DashboardTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var balance: UILabel!
    @IBOutlet weak var accountNumber: UILabel!
    @IBOutlet weak var bgView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.layer.cornerRadius = 4
        bgView.backgroundColor = .lightText
        balance.font = UIFont.boldSystemFont(ofSize: 24)
        balance.textColor = .systemYellow
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
    
}
