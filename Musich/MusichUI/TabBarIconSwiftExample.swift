/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

import UIKit

import MaterialComponents.MaterialAppBar
import MaterialComponents.MaterialPalettes
import MaterialComponents.MaterialTabs
import MaterialComponents.MaterialButtons

class TabBarIconSwiftExample: UIViewController {
    
    // MARK: Properties
    var alignment: MDCTabBarAlignment {
        get {
            return tabBar.alignment
        }
        set(newAlignment) {
            tabBar.setAlignment(newAlignment, animated: true)
        }
    }
    
    lazy var alignmentButton: MDCRaisedButton = self.setupAlignmentButton()
    
    lazy var appBar: MDCAppBar = self.setupAppBar()
    
    lazy var scrollView: UIScrollView = self.setupScrollView()
    
    lazy var starPage: UIView = self.setupStarPage()
    
    lazy var tabBar: MDCTabBar = {
        let tabBar = MDCTabBar()
        tabBar.delegate = self
        tabBar.alignment = .centerSelected
        
        let bundle = Bundle(for: TabBarIconSwiftExample.self)
        let info = UIImage.init(named: "TabBarDemo_ic_info", in: bundle, compatibleWith:nil)
        let star = UIImage.init(named: "TabBarDemo_ic_star", in: bundle, compatibleWith:nil)
        
        tabBar.items = [UITabBarItem(title: "Info", image: info, tag:0),
                        UITabBarItem(title: "Stars", image: star, tag:0)]
        tabBar.items[1].badgeValue = "1"
        
        let blue = MDCPalette.blue.tint500
        tabBar.tintColor = blue
        tabBar.inkColor = blue
        
        tabBar.barTintColor = UIColor.white
        tabBar.itemAppearance = .titledImages
        tabBar.selectedItemTintColor = UIColor.black.withAlphaComponent(0.87)
        tabBar.unselectedItemTintColor = UIColor.black.withAlphaComponent(0.38)
        
        return tabBar
    }()
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupExampleViews()
        
        alignmentButton.addTarget(self,
                                  action:#selector(changeAlignmentDidTouch(sender:)),
                                  for: .touchUpInside)
    }
    
    @objc func changeAlignmentDidTouch(sender: UIButton) {
        let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Leading", style: .default, handler: { _ in
            self.alignment = .leading
        }))
        sheet.addAction(UIAlertAction(title: "Center", style: .default, handler: { _ in
            self.alignment = .center
        }))
        sheet.addAction(UIAlertAction(title: "Justified", style: .default, handler: { _ in
            self.alignment = .justified
        }))
        sheet.addAction(UIAlertAction(title: "Selected Center", style: .default, handler: { _ in
            self.alignment = .centerSelected
        }))
        present(sheet, animated: true, completion:nil)
    }
    
    func incrementStarBadge() {
        let starItem = tabBar.items[1]
        guard let badgeValue = starItem.badgeValue,
            let badgeNumber = Int(badgeValue), badgeNumber > 0 else {
                return
        }
        
        starItem.badgeValue = NumberFormatter.localizedString(from:(badgeNumber + 1) as NSNumber,
                                                              number: .none)
    }
    
    // MARK: Action
    @objc func incrementDidTouch(sender: UIBarButtonItem) { incrementStarBadge()
        
        //  addStar(centered: false)
    }
    
}

// MARK: Tab Bar delegate
extension TabBarIconSwiftExample: MDCTabBarDelegate {
    func tabBar(_ tabBar: MDCTabBar, didSelect item: UITabBarItem) {
        guard let index = tabBar.items.index(of: item) else {
            fatalError("MDCTabBarDelegate given selected item not found in tabBar.items")
        }
        
        scrollView.setContentOffset(CGPoint(x: CGFloat(index) * view.bounds.width, y: 0),
                                    animated: true)
    }
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .bottom
    }
}

extension TabBarIconSwiftExample {
    
    func setupAlignmentButton() -> MDCRaisedButton {
        let alignmentButton = MDCRaisedButton()
        
        alignmentButton.setTitle("Change Alignment", for: .normal)
        alignmentButton.setTitleColor(.white, for: .normal)
        
        self.view.addSubview(alignmentButton)
        alignmentButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: alignmentButton,
                           attribute: .centerX,
                           relatedBy: .equal,
                           toItem: self.view,
                           attribute: .centerX,
                           multiplier: 1,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: alignmentButton,
                           attribute: .bottom,
                           relatedBy: .equal,
                           toItem: self.view,
                           attribute: .bottom,
                           multiplier: 1,
                           constant: -40).isActive = true
        
        return alignmentButton
    }
    
    func setupAppBar() -> MDCAppBar {
        let appBar = MDCAppBar()
        
        self.addChildViewController(appBar.headerViewController)
        appBar.headerViewController.headerView.backgroundColor = UIColor.white
        appBar.headerViewController.headerView.minMaxHeightIncludesSafeArea = false
        appBar.headerViewController.headerView.minimumHeight = 56 + 72
        appBar.headerViewController.headerView.tintColor = MDCPalette.blue.tint500
        
        appBar.headerStackView.bottomBar = self.tabBar
        appBar.headerStackView.setNeedsLayout()
        return appBar
    }
    
    func setupExampleViews() {
        view.backgroundColor = UIColor.white
        
        appBar.addSubviewsToParent()
        
        let badgeIncrementItem = UIBarButtonItem(title: "Add",
                                                 style: .plain,
                                                 target: self,
                                                 action:#selector(incrementDidTouch(sender: )))
        
        self.navigationItem.rightBarButtonItem = badgeIncrementItem
        
        self.title = "Tabs With Icons"
        
        setupScrollingContent()
    }
    
    func setupScrollView() -> UIScrollView {
        let scrollView = UIScrollView(frame: CGRect())
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isPagingEnabled = false
        scrollView.isScrollEnabled = false
        self.view.addSubview(scrollView)
        
        scrollView.backgroundColor = UIColor.red
        
        let views = ["scrollView": scrollView, "header": self.appBar.headerStackView]
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:[header][scrollView]|",
                                                                   options: [],
                                                                   metrics: nil,
                                                                   views: views))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[scrollView]|",
                                                                   options: [],
                                                                   metrics: nil,
                                                                   views: views))
        
        return scrollView
    }
    
    func setupScrollingContent() {
        // The scrollView will have two UIViews (pages.) One has a label with text (infoLabel); we call
        // this infoPage. Another has 1+ star images; we call this self.starPage. Tapping on the 'INFO'
        // tab will show the infoPage and tapping on the 'STARS' tab will show the self.starPage.
        
        // Create the first view and its content. Then add to scrollView.
        
        let infoPage = UIView(frame: CGRect())
        infoPage.translatesAutoresizingMaskIntoConstraints = false
        infoPage.backgroundColor = MDCPalette.lightBlue.tint300
        scrollView.addSubview(infoPage)
        
        let infoLabel = UILabel(frame: CGRect())
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.textColor = UIColor.white
        infoLabel.numberOfLines = 0
        infoLabel.text = "Tabs enable content organization at a high level,"
            + " such as switching between views"
        infoPage.addSubview(infoLabel)
        
        // Layout the views to be equal height and width to each other and self.view,
        // hug the edges of the scrollView and meet in the middle.
        
        NSLayoutConstraint(item: infoLabel,
                           attribute: .centerX,
                           relatedBy: .equal,
                           toItem: infoPage,
                           attribute: .centerX,
                           multiplier: 1,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: infoLabel,
                           attribute: .centerY,
                           relatedBy: .equal,
                           toItem: infoPage,
                           attribute: .centerY,
                           multiplier: 1,
                           constant: -50).isActive = true
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|-50-[infoLabel]-50-|",
                                                                   options: [],
                                                                   metrics: nil,
                                                                   views: ["infoLabel": infoLabel]))
        NSLayoutConstraint(item: infoPage,
                           attribute: .width,
                           relatedBy: .equal,
                           toItem: self.view,
                           attribute: .width,
                           multiplier: 1,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: infoPage,
                           attribute: .height,
                           relatedBy: .equal,
                           toItem: self.scrollView,
                           attribute: .height,
                           multiplier: 1,
                           constant: 0).isActive = true
        
        NSLayoutConstraint(item: self.starPage,
                           attribute: .width,
                           relatedBy: .equal,
                           toItem: infoPage,
                           attribute: .width,
                           multiplier: 1,
                           constant: 0).isActive = true
        
        let views = ["infoPage": infoPage, "starPage": self.starPage]
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[infoPage][starPage]|",
                                                                   options: [.alignAllTop,
                                                                             .alignAllBottom],
                                                                   metrics: nil,
                                                                   views: views))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[infoPage]|",
                                                                   options: [],
                                                                   metrics: nil,
                                                                   views: views))
        
        addStar(centered: true)
    }
    
    func setupStarPage() -> UIView {
        let starPage = UIView(frame: CGRect())
        starPage.translatesAutoresizingMaskIntoConstraints = false
        starPage.backgroundColor = MDCPalette.lightBlue.tint200
        self.scrollView.addSubview(starPage)
        
        return starPage
    }
    
    func addStar(centered: Bool) {
        let starImage = UIImage(named:"TabBarDemo_ic_star",
                                in:Bundle(for: TabBarIconSwiftExample.self),
                                compatibleWith:nil)
        let starView = UIImageView(image: starImage)
        starView.translatesAutoresizingMaskIntoConstraints = false
        starPage.addSubview(starView)
        starView.sizeToFit()
        
        let x = centered ? 1.0 : (CGFloat(arc4random_uniform(199) + 1) / 100.0) // 0 < x <=2
        let y = centered ? 1.0 : (CGFloat(arc4random_uniform(199) + 1) / 100.0) // 0 < y <=2
        
        NSLayoutConstraint(item: starView,
                           attribute: .centerX,
                           relatedBy: .equal,
                           toItem: starPage,
                           attribute: .centerX,
                           multiplier: x,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: starView,
                           attribute: .centerY,
                           relatedBy: .equal,
                           toItem: self.starPage,
                           attribute: .centerY,
                           multiplier: y,
                           constant: 0).isActive = true
    }
}

extension TabBarIconSwiftExample {
    override var childViewControllerForStatusBarStyle: UIViewController? {
        return appBar.headerViewController
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (_) in
            if let selectedItem = self.tabBar.selectedItem {
                self.tabBar(self.tabBar, didSelect: selectedItem)
            }
        }, completion: nil)
        super.viewWillTransition(to: size, with: coordinator)
    }
}

// MARK: - Catalog by convention
extension TabBarIconSwiftExample {
    @objc class func catalogBreadcrumbs() -> [String] {
        return ["Tab Bar", "Icons and Text (Swift)"]
    }
    
    @objc class func catalogIsPrimaryDemo() -> Bool {
        return false
    }
    
    func catalogShouldHideNavigation() -> Bool {
        return true
    }
    
    @objc class func catalogIsPresentable() -> Bool {
        return true
    }
}

