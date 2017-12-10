//
//  AppDelegate.swift
//  PUBGCompanion
//
//  Created by Kel Robertson on 27/08/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//
import UIKit
import GoogleMobileAds
import FBSDKCoreKit
import FBSDKLoginKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    internal var shouldRotate = false
    
    func application(_ application: UIApplication,
                     supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return shouldRotate ? .allButUpsideDown : .portrait
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore  {
            print("Not first launch.")
            
        } else {
            print("First launch, setting UserDefault.")
            if let pName = UserDefaults.standard.string(forKey: "playerName") {
                if pName != "", pName != nil {
//                    PUBGME.instance.PubgmeOverview(name: pName, completed: { (success, msg, data) in })
//                    if let mPNumber = UserDefaults.standard.string(forKey: "matchHistoryPage") {
//                        PUBGME.instance.PubgmeMatchHistory(name: pName, pageNumber: mPNumber, completed: { (success, msg, data) in })
//                    } else {
//                        PUBGME.instance.PubgmeMatchHistory(name: pName, pageNumber: "1" , completed: { (success, msg, data) in })
//                    }
                    PUBGTRACKER.instance.PlayerData(name: pName, completed: { (success, msg) in
                        
                    })
                }
                
            }
            UserDefaults.standard.set(true, forKey: "launchedBefore")
        }
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        FBSDKAppEvents.activateApp()
        GADMobileAds.configure(withApplicationID: "ca-app-pub-7739741947193555~8181653993")
            return true

    }
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        let handled: Bool = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, options: options)
        // Add any custom logic here.
        return handled
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        /*
         Useful if user returns to your app from the background after being sent to the
         App Store, but doesn't update their app before coming back to your app.
         
         
         
         ONLY USE WITH Siren.AlertType.immediately
         */
        
        
        if currentReachabilityStatus != .notReachable
        {

        }
        else
        {
            let controller = UIAlertController(title: "No Internet Detected", message: "This app requires an Internet connection, the application wiil not work correctly.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

            controller.addAction(ok)
            controller.addAction(cancel)

            self.window?.rootViewController?.present(controller, animated: true, completion: nil)

        }
        
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {

        
        /*
         Perform daily (.daily) or weekly (.weekly) checks for new version of your app.
         Useful if user returns to your app from the background after extended period of time.
         Place in applicationDidBecomeActive(_:).	*/
        
        if currentReachabilityStatus != .notReachable
        {
            
        }
        else
        {
            let controller = UIAlertController(title: "No Internet Detected", message: "This app requires an Internet connection, the application wiil not work correctly.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            controller.addAction(ok)
            controller.addAction(cancel)
            
            self.window?.rootViewController?.present(controller, animated: true, completion: nil)
            
        }
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

extension UIImage{
    convenience init(view: UIView) {
        
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: false)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: (image?.cgImage)!)
        
    }
}


extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
extension String {
    func substr(_ start:Int, length:Int=0) -> String? {
        guard start > -1 else {
            return nil
        }
        
        let count = self.characters.count - 1
        
        guard start <= count else {
            return nil
        }
        
        let startOffset = max(0, start)
        let endOffset = length > 0 ? min(count, startOffset + length - 1) : count
        
        return self[self.index(self.startIndex, offsetBy: startOffset)...self.index(self.startIndex, offsetBy: endOffset)]
    }
}
public extension Sequence where Iterator.Element: Hashable {
    var uniqueElements: [Iterator.Element] {
        return Array( Set(self) )
    }
}
public extension Sequence where Iterator.Element: Equatable {
    var uniqueElements: [Iterator.Element] {
        return self.reduce([]){
            uniqueElements, element in
            
            uniqueElements.contains(element)
                ? uniqueElements
                : uniqueElements + [element]
        }
    }
}
extension CALayer {
    
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        
        let border = CALayer()
        
        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: thickness)
            break
        case UIRectEdge.bottom:
            border.frame = CGRect(x: 0, y: self.frame.height - thickness, width: self.frame.width, height: thickness)
            break
        case UIRectEdge.left:
            border.frame = CGRect(x: 0, y: 0, width: thickness, height: self.frame.height)
            break
        case UIRectEdge.right:
            border.frame = CGRect(x: self.frame.width - thickness, y: 0, width: thickness, height: self.frame.height)
            break
        default:
            //For Center Line
            border.frame = CGRect(x: self.frame.width/2 - thickness, y: 0, width: thickness, height: self.frame.height)
            break
        }
        
        border.backgroundColor = color.cgColor;
        self.addSublayer(border)
    }
}
extension Date {
    
    func offsetFrom(date: Date) -> String {
        
        let dayHourMinuteSecond: Set<Calendar.Component> = [.day, .hour, .minute, .second]
        let difference = NSCalendar.current.dateComponents(dayHourMinuteSecond, from: date, to: self);
        
        let seconds = "\(difference.second ?? 0)s"
        let minutes = "\(difference.minute ?? 0)m" + " " + seconds
        let hours = "\(difference.hour ?? 0)h" + " " + minutes
        let days = "\(difference.day ?? 0)d" + " " + hours
        
        if let day = difference.day, day          > 0 { return days }
        if let hour = difference.hour, hour       > 0 { return hours }
        if let minute = difference.minute, minute > 0 { return minutes }
        if let second = difference.second, second > 0 { return seconds }
        return ""
    }
    
}
