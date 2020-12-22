//
//  DaysTableView.swift
//  Weather
//
//  Created by Nik on 22.12.2020.
//

import UIKit
import CoreDataKit

class DaysTableView: UITableView, UITableViewDataSource, UITableViewDelegate {

    private var sections = [Sections]()
    private var rootController: DaysViewController!
    private var nowSectionType: SectionType = .list

    private var weeklyWeather = [WeeklyDay]()

    // MARK: - init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSettings()
    }

    // MARK: - TableView
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = dequeueReusableHeaderFooterView(withIdentifier: TableSectionHeader.identifier) as! TableSectionHeader
        let rowSection = sections[section]

        if rowSection.getType().getIsHidden() {
            return UIView()
        }

        cell.loadSection(rowSection)
        cell.isShowAllButton(rowSection.getType().getIsShowAll())
        cell.background.backgroundColor = .clear
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rowSection = sections[section].getType()

        switch rowSection.getId() {
        case SectionEntity.DaysList.getId():
            return weeklyWeather.isEmpty ? 1 : weeklyWeather.count
        default:
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rowSection = sections[indexPath.section].getType()

        switch rowSection.getId() {
        case SectionEntity.DaysList.getId():
            return loadDayItemCell(indexPath)
        default:
            return loadSubstrateCell(indexPath)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let rowSection = sections[section].getType()
        return rowSection.getIsHidden() ? 1 : rowSection.getSubTitle().isNotEmpty() ? 60 : 35
    }

    // MARK: - Settings
    func initSettings() {
        dataSource = self
        delegate = self

        estimatedRowHeight = 200
        sectionFooterHeight = 0
        separatorStyle = .none

        let nib = UINib(nibName: TableSectionHeader.identifier, bundle: nil)
        register(nib, forHeaderFooterViewReuseIdentifier: TableSectionHeader.identifier)
    }

    // MARK: - Additional functions
    func loadInfo(_ rootController: DaysViewController) {
        self.rootController = rootController

        sections = Sections.createSections(nowSectionType)
        weeklyWeather = CoreDataManager.loadFromDb(clazz: WeeklyDay.self, keyForSort: Const.SORT_DATE_TIME)
        
        UIView.transition(
            with: self,
            duration: 0.3,
            options: [.transitionCrossDissolve, UIView.AnimationOptions.beginFromCurrentState],
            animations: {
                self.reloadData()
        })
    }

    func loadDayItemCell(_ indexPath: IndexPath) -> UITableViewCell {
        if weeklyWeather.isEmpty {
            return loadSubstrateCell(indexPath)
        }

        let cell = dequeueReusableCell(withIdentifier: WeeklyDayCell.identifier, for: indexPath) as! WeeklyDayCell
        let rowDay = weeklyWeather[indexPath.row]
        
        cell.loadCell(rowDay)
        return cell
    }

    func loadSubstrateCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: SubstrateCell.identifier, for: indexPath) as! SubstrateCell
        let rowSection = sections[indexPath.section]

        cell.loadCell(rowSection.getEmptyTitle(), rowSection.getEmptySubTitle())

        return cell
    }
}
