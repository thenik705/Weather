//
//  HourlyWeatherCollectionView.swift
//  Weather
//
//  Created by Nik on 21.12.2020.
//

import UIKit
import CoreDataKit

//protocol CategoriesCollectionViewControllerDelegate: class {
//    func selectCategories(_ category: Categories?)
//}

class HourlyWeatherCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    private var hourlies = [Hourlies]()

//    weak var categoriesDelegate: CategoriesCollectionViewControllerDelegate?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSettings()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourlies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let rowHourly = hourlies[indexPath.row]

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyWeatherItemCell.identifier, for: indexPath) as! HourlyWeatherItemCell
        cell.loadCell(rowHourly)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }

     func initSettings() {
        dataSource = self
        delegate = self

        backgroundColor = nil
    }

    // MARK: - Additional functions
    func setHourliesWeather(_ hourliesWeather: [Hourlies]) {
        self.hourlies = hourliesWeather
        self.reloadData()
    }
}

