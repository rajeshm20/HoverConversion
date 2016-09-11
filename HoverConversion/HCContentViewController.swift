//
//  HCContentViewController.swift
//  HoverConversion
//
//  Created by Taiki Suzuki on 2016/07/18.
//  Copyright © 2016年 marty-suzuki. All rights reserved.
//

import UIKit

public protocol HCContentViewControllerScrollDelegate: class {
    func contentViewController(viewController: HCContentViewController, scrollViewWillBeginDragging scrollView: UIScrollView)
    func contentViewController(viewController: HCContentViewController, scrollViewDidScroll scrollView: UIScrollView)
    func contentViewController(viewController: HCContentViewController, scrollViewDidEndDragging scrollView: UIScrollView, willDecelerate decelerate: Bool)
}

public class HCContentViewController: UIViewController, HCViewContentable {
    
    public var tableView: UITableView! = UITableView()
    public var navigatoinContainerView: UIView! = UIView()
    public var navigationView: HCNavigationView! = HCNavigationView(buttonPosition: .Left)
    let cellImageView = UIImageView(frame: .zero)
    
    public weak var scrollDelegate: HCContentViewControllerScrollDelegate?
    
    public override var title: String? {
        didSet {
            navigationView?.titleLabel.text = title
        }
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        automaticallyAdjustsScrollViewInsets = false
        addViews()
        tableView.delegate = self
        view.addSubview(cellImageView)
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func navigationView(navigationView: HCNavigationView, didTapLeftButton button: UIButton) {
        navigationController?.popViewControllerAnimated(true)
    }
}

extension HCContentViewController: UITableViewDelegate {
    public func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        scrollDelegate?.contentViewController(self, scrollViewWillBeginDragging: scrollView)
    }
    
    public func scrollViewDidScroll(scrollView: UIScrollView) {
        scrollDelegate?.contentViewController(self, scrollViewDidScroll: scrollView)
    }
    
    public func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        scrollDelegate?.contentViewController(self, scrollViewDidEndDragging: scrollView, willDecelerate: decelerate)
    }
}