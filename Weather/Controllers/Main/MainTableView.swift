//
//  MainTableView.swift
//  Weather
//
//  Created by Nik on 20.12.2020.
//

import UIKit
import CoreDataKit

class MainTableView: UITableView, UITableViewDataSource, UITableViewDelegate {

    private var sections = Sections.createSections()
    private var weather: Weather?
    private var rootController: MainViewController!

//    weak var mainTableDelegate: MainTableDelegate?

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
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rowSection = sections[indexPath.section].getType()

        switch rowSection.getId() {
        case SectionEntity.Header.getId():
            return loadHeaderCell(indexPath)
        case SectionEntity.Current.getId():
            return loadWeatherInfoCell(indexPath)
        case SectionEntity.Hourly.getId():
            return loadHourlyCell(indexPath)
        case SectionEntity.Action.getId():
            return loadDaysListCell(indexPath)
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

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let rowSection = sections[section].getType()
        return rowSection.getIsHidden() ? 1 : 15
    }

    // MARK: - Settings
    func initSettings() {
        dataSource = self
        delegate = self

        estimatedRowHeight = 200
        sectionFooterHeight = 0
        tableFooterView = UIView(frame: .zero)

        let nib = UINib(nibName: TableSectionHeader.identifier, bundle: nil)
        register(nib, forHeaderFooterViewReuseIdentifier: TableSectionHeader.identifier)
    }

    // MARK: - Additional functions
    func setInfo(_ weather: Weather?, rootController: MainViewController) {
        self.weather = weather
        self.rootController = rootController
        
        reloadData()
    }

    func loadHeaderCell(_ indexPath: IndexPath) -> UITableViewCell {
         let cell = dequeueReusableCell(withIdentifier: HeaderCell.identifier, for: indexPath) as! HeaderCell
        if let weather = weather {
            cell.loadCell(weather)
        }
        cell.delegate = rootController
        return cell
    }

    func loadWeatherInfoCell(_ indexPath: IndexPath) -> UITableViewCell {
        if let weather = weather {
            let cell = dequeueReusableCell(withIdentifier: WeatherInfoCell.identifier, for: indexPath) as! WeatherInfoCell
            cell.loadCell(weather)
            return cell
        }
        
        return loadSubstrateCell(indexPath)
    }

    func loadHourlyCell(_ indexPath: IndexPath) -> UITableViewCell {
        let hourlies = weather?.getAllHourlies(Const.SORT_DATE_TIME) ?? [Hourlies]()

        if !(hourlies.isEmpty) {
            let cell = dequeueReusableCell(withIdentifier: HourlyCell.identifier, for: indexPath) as! HourlyCell
            cell.loadCell(hourlies)
            return cell
        } else {
            return loadSubstrateCell(indexPath)
        }
    }

    func loadDaysListCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: DaysListCell.identifier, for: indexPath) as! DaysListCell
        cell.loadCell()
        cell.daysListDelegate = rootController
        return cell
    }

    func loadSubstrateCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: SubstrateCell.identifier, for: indexPath) as! SubstrateCell
        let rowSection = sections[indexPath.section]

        cell.loadCell(rowSection.getEmptyTitle(), rowSection.getEmptySubTitle())

        return cell
    }
}
