//
//  MainTabBarController.swift
//  Sprint2
//
//  Created by Capgemini-DA401 on 9/21/22.
//

import Foundation
import UIKit

class MainTabBarController : UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //hide the Navigation Bar
        self.navigationController?.navigationBar.isHidden = true
    }
}
