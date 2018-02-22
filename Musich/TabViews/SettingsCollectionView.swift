import UIKit
import MaterialComponents.MaterialAppBar
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialCollections

class SettingsCollectionView: MDCCollectionViewController {
    let appBar = MDCAppBar()
    let fab = MDCFloatingButton()
    
    //Settings View Constants
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styler.cellStyle = .card
    }
    
    @objc func barButtonDidTap(sender: UIBarButtonItem) {
        editor.isEditing = !editor.isEditing
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: editor.isEditing ? "Cancel" : "Edit", style: .plain, target: self, action: #selector(self.barButtonDidTap))
    }
    
    @objc func fabDidTap(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        self.dismiss(animated: true, completion: nil)
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
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
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
    

    
    
    // MARK: UIScrollViewDelegate
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == appBar.headerViewController.headerView.trackingScrollView {
            appBar.headerViewController.headerView.trackingScrollDidScroll()
        }
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == appBar.headerViewController.headerView.trackingScrollView {
            appBar.headerViewController.headerView.trackingScrollDidEndDecelerating()
        }
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == appBar.headerViewController.headerView.trackingScrollView {
            let headerView = appBar.headerViewController.headerView
            headerView.trackingScrollDidEndDraggingWillDecelerate(decelerate)
        }
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if scrollView == appBar.headerViewController.headerView.trackingScrollView {
            let headerView = appBar.headerViewController.headerView
            headerView.trackingScrollWillEndDragging(withVelocity: velocity, targetContentOffset: targetContentOffset)
        }
    }
}
