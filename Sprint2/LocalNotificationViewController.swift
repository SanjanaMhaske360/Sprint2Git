//
//  LocalNotificationViewController.swift
//  Sprint2
//
//  Created by Capgemini-DA401 on 9/21/22.
//

import UIKit
import UserNotifications

class LocalNotificationViewController: UIViewController ,UNUserNotificationCenterDelegate {
    

    @IBOutlet weak var notificationbtn: UIButton!
    //variable for Notification Center
    let notificationCenter = UNUserNotificationCenter.current()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //corner Radius For Notification
        notificationbtn.layer.cornerRadius = 25.0
        notificationbtn.layer.masksToBounds = true
        notificationbtn.layer.borderWidth = 4
        notificationbtn.layer.borderColor = CGColor(srgbRed: 255/255, green: 126/255, blue: 121/255, alpha: 1)
        notificationCenter.delegate = self
    }
    
    
    // Action ForbLocal Notification Button
    @IBAction func localNotification(_ sender: Any) {
        
        // Reuest to Customer for Notication
        notificationCenter.requestAuthorization(options: [.alert,.sound]) { (allowed, error) in
            if allowed
            {
             print("Notification Permission Granted")
            }
            else {
               print("Notification Permission not Granted")
            }
         }
        
        // Content For Notification
        let content = UNMutableNotificationContent()
        content.title = "Order Succesfully Completed!!!"
        content.body = "Your Product Will Reach Soon "
        content.sound = .default
        
        //Notification Trigger with TimeInterval of 10 sec
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        let request = UNNotificationRequest(identifier: "localNotificationIdentifier", content: content, trigger: trigger)
        
        //when Error Occued in Notification
        notificationCenter.add(request) { (error) in
            print(error?.localizedDescription)
        }
    

}
}

