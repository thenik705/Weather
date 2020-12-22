//
//  SectionEntity.swift
//  Weather
//
//  Created by Nik on 20.12.2020.
//

import UIKit

class SectionEntity {

    static public let Header = SectionEntity(0, title: "Header", isHidden: true)
    static public let Current = SectionEntity(1, title: "Current", isHidden: true)
    static public let Hourly = SectionEntity(2, title: "Today", subTitle: "The weather will be")
    static public let Action = SectionEntity(3, title: "Action", isHidden: true)
    static public let DaysList = SectionEntity(4, title: "Next 7 Days")

    static public func allValues() -> [SectionEntity] {
        return [Header, Current, Hourly, Action, DaysList]
    }

    static public func mainValues() -> [SectionEntity] {
        return [Header, Current, Hourly, Action]
    }

    static public func listValues() -> [SectionEntity] {
        return [DaysList]
    }

    static public func getValues(_ sectionType: SectionType = .main) -> [SectionEntity] {
        return values(sectionType)
    }

    static public func getAddValuesIndex(_ sectionType: SectionType = .main, _ type: SectionEntity) -> Int {
        let typeValues = values(sectionType)
        return typeValues.firstIndex(where: { $0.itemId == type.itemId }) ?? 0
    }

    private let itemId: Int
    private var title: String
    private var subTitle: String?
    private var emptyTitle: String
    private var emptySubTitle: String
    private var isHidden: Bool
    private var isShowAll: Bool

    fileprivate init(_ itemId: Int, title: String, subTitle: String? = nil, emptyTitle: String = "", emptySubTitle: String = "", isHidden: Bool = false, isShowAll: Bool = false) {
        self.itemId = itemId
        self.title = title
        self.subTitle = subTitle
        self.emptyTitle = emptyTitle
        self.emptySubTitle = emptySubTitle
        self.isHidden = isHidden
        self.isShowAll = isShowAll
    }

    static public func byId(_ itemId: Int) -> SectionEntity? {
        return allValues().first(where: { $0.itemId == itemId })
    }

    static public func byTitle(_ title: String) -> SectionEntity? {
        return allValues().first(where: { $0.title == title })
    }

    static public func values(_ sectionType: SectionType = .main) -> [SectionEntity] {
        var volues = allValues()

        switch sectionType {
        case .main:
            volues = mainValues()
            let current = volues.first(where: { $0.itemId == Current.getId() })
            current?.setEmptyTitleAndSubTitle("Empty", "No location data")

            let history = volues.first(where: { $0.itemId == Hourly.getId() })
            history?.setEmptyTitleAndSubTitle("Empty", "No recent data")
        case .list:
            volues = listValues()
            
            let list = volues.first(where: { $0.itemId == DaysList.getId() })
            list?.setEmptyTitleAndSubTitle("Empty", "No recent data")
        default:
            print("NO SectionType!")
        }

        return volues
    }

    func setTitle(_ title: String) {
        self.title = title
    }

    func setSubTitle(_ subTitle: String) {
        self.subTitle = subTitle
    }

    public func getId() -> Int {
        return itemId
    }

    public func getTitle() -> String {
        return title
    }

    public func getSubTitle() -> String {
        return subTitle ?? ""
    }

    public func getEmptyTitle() -> String {
        return emptyTitle
    }

    public func getEmptySubTitle() -> String {
        return emptySubTitle
    }
    
    public func getIsShowAll() -> Bool {
        return isShowAll
    }

    private func setEmptyTitleAndSubTitle(_ title: String?, _ subTitle: String?) {
        emptyTitle = title ?? ""
        emptySubTitle = subTitle ?? ""
    }

    public func getIsHidden() -> Bool {
        return isHidden
    }
}

