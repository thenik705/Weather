//
//  TableSectionHeader.swift
//  Weather
//
//  Created by Nik on 20.12.2020.
//

import UIKit
//import CoreDataKit

protocol TableSectionHeaderViewDelegate: class {
//    func tappedSection(_ sectionType: DateRangeEntity?)
}

class TableSectionHeader: UITableViewHeaderFooterView {

    static let identifier = "TableSectionHeader"

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var allButton: UIButton!

    @IBOutlet weak var subTitleHeight: NSLayoutConstraint!

    weak var delegate: TableSectionHeaderViewDelegate?

    func loadSection(_ section: Sections) {

        title.text = section.getTitle()
        subTitle.text = section.getSubTitle()
    }

    func isShowAllButton(_ show: Bool = false) {
        allButton.alpha = show ? 1 : 0
    }

    @IBAction func tappedAllButtonAction(_ sender: Any) {
//        delegate?.tappedSection(section?.type)
    }
}

