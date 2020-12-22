//
//  Sections.swift
//  Weather
//
//  Created by Nik on 20.12.2020.
//

import Foundation

enum SectionType {
    case main
    case list
}

class Sections {
    private var itemId: Int
    private var title: String
    private var subTitle: String
    private var emptyTitle: String
    private var emptySubTitle: String

    private init(_ itemId: Int, _ title: String, _ subTitle: String, emptyTitle: String = "", emptySubTitle: String = "") {
        self.itemId = itemId
        self.title = title
        self.subTitle = subTitle
        self.emptyTitle = emptyTitle
        self.emptySubTitle = emptySubTitle
    }

    static func createSections(_ sectionType: SectionType = .main) -> [Sections] {
        var sections = [Sections]()

        SectionEntity.getValues(sectionType).forEach { (section) in
            sections.append(Sections(section.getId(), section.getTitle(), section.getSubTitle(), emptyTitle: section.getEmptyTitle(), emptySubTitle: section.getEmptySubTitle()))
        }

        return sections
    }

    func getId() -> Int {
        return itemId
    }

    func getTitle() -> String {
        return title
    }

    func getSubTitle() -> String {
        return subTitle
    }
    
    func getEmptyTitle() -> String {
        return emptyTitle
    }
    
    func getEmptySubTitle() -> String {
        return emptySubTitle
    }
    
    func getType() -> SectionEntity {
        return SectionEntity.byId(itemId) ?? SectionEntity.Hourly
    }
}

