//
//  SettingsCollectionViewController.swift
//  Musich
//
//  Created by Loaner on 2/25/18.
//  Copyright © 2018 baksha97. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialAppBar
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialCollections

private let reuseIdentifier = "SettingsCell"

class SettingsCollectionViewController: MDCCollectionViewController {

//Settings View Constants

    override func viewDidLoad() {
        super.viewDidLoad()
        self.styler.cellLayoutType = .list
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ProfileServices.shared.dataCount()
    }

    override func collectionView(_ collectionView: UICollectionView, shouldHideHeaderSeparatorForSection section: Int) -> Bool {
        return false;
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)

        if let textCell = cell as? MDCCollectionViewTextCell {

            // Add some mock text to the cell.
            textCell.textLabel?.text = ProfileServices.shared.getDisplayText(for: indexPath.item)
            textCell.detailTextLabel?.textAlignment = .right
            textCell.detailTextLabel?.text = ProfileServices.shared.getCurrentUserValue(for: ProfileServices.shared.getDisplayText(for: indexPath.item))
        }

        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}
