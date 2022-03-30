//
//  TransactionTableViewCell.swift
//  OCBCTest
//
//  Created by Rajesh on 28/3/22.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var balance: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var accountNumber: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.layer.cornerRadius = 4
        bgView.backgroundColor = .lightText
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
