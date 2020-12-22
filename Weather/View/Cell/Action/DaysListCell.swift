//
//  DaysListCell.swift
//  Weather
//
//  Created by Nik on 22.12.2020.
//

import UIKit

protocol DaysListDelegate: class {
    func tapDaysAction()
}

class DaysListCell: UITableViewCell {

    static let identifier = "DaysListCell"

    @IBOutlet weak var daysListButton: UIButton!

    weak var daysListDelegate: DaysListDelegate?

    func loadCell() {
        daysListButton.setTitle("Next 7 days", for: .normal)
        daysListButton.setTitleColor(#colorLiteral(red: 0.09188886732, green: 0.5096402168, blue: 0.9950761199, alpha: 1), for: .normal)
        daysListButton.startAnimatingPressActions()
        backgroundColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func addEntityButtonAction(_ sender: Any) {
        daysListDelegate?.tapDaysAction()
    }
}

