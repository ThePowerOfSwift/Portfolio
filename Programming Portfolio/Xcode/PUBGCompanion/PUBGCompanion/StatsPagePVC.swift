//
//  StatsPagePVC.swift
//  PUBG Hub
//
//  Created by Kel Robertson on 18/09/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class StatsPagePVC: UIPageViewController, UIPageViewControllerDelegate,UIPageViewControllerDataSource {
    
    lazy var ViewControllers: [UIViewController] = {
        return [self.VCInstnace("overallExtendedVC"), self.VCInstnace("MatchHistory")]
    }()
    
    fileprivate func VCInstnace(_ name: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: name)
    }
    
    weak var actionToEnable : UIAlertAction?
    var activity: NVActivityIndicatorView!
    
    let searchName = UserDefaults.standard.object(forKey: "playerName")
    
    var PageNumber: Int! = 0
    var menuList = [String]()
    var overViewData = PUBGTRACKER.instance.stats
    var matchHistory = PUBGTRACKER.instance.matchHistory

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        
        if let firstVC = ViewControllers.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
            
        }
        HandlePageData(index: self.PageNumber)
    }
    
    
    func HandlePageData(index:Int){
        switch PageNumber {
        case 0:
            if let controller = self.ViewControllers[self.PageNumber] as? OverallExtendedVC {
                controller.SetupData()
                let rightButtonItem = UIBarButtonItem.init(
                    title: "Compare",
                    style: .done,
                    target: self,
                    action: #selector(CompareButton(sender:))
                )
                
                self.navigationItem.rightBarButtonItem = rightButtonItem
            }
            break
        case 1:
            self.navigationItem.title = "Match History"
            break
        default:
            break
        }

    }
    
    func CompareButton(sender: UIBarButtonItem) {
        if let controller = ViewControllers[0] as? OverallExtendedVC {
            controller.ComparePressed(sender: sender)
        }
    }
    
    func LoadActivity() {
        let screenWidth = self.view.frame.size.width
        let screenHeight = self.view.frame.size.width
        activity = NVActivityIndicatorView(frame: CGRect(x: screenWidth / 2 ,y: screenHeight / 2, width: 100 , height:100 ) , type: .ballScaleRippleMultiple, color: Y_ORANGE, padding: 10)
        self.view.addSubview(activity)
        activity.center.x = self.view.center.x
        activity.layer.cornerRadius = 50
        activity.backgroundColor = DARK_GREY
        activity.startAnimating()
    }

    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {

    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool)
    {
        guard completed else { return }
        self.PageNumber = pageViewController.viewControllers!.first!.view.tag
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = ViewControllers.index(of: viewController) else {
            return nil
        }
        let previousIndex = vcIndex - 1
        guard previousIndex >= 0 else {
            return ViewControllers.last
        }
        guard ViewControllers.count > previousIndex else {
            return nil
        }
        return ViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = ViewControllers.index(of: viewController) else {
            return nil
        }
        let nextIndex = vcIndex + 1
        guard nextIndex < ViewControllers.count else {
            return ViewControllers.first
        }
        guard ViewControllers.count > nextIndex else {
            return nil
        }
        return ViewControllers[nextIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return ViewControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstVC = ViewControllers.first, let firstVCIndex = ViewControllers.index(of: firstVC) else {
            return 0
        }
        return firstVCIndex
    }
}
