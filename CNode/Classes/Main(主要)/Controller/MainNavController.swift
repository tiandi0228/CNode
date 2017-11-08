//
//  MainNavController.swift
//  CNode
//
//  Created by sunyuchun on 2017/11/2.
//  Copyright © 2017年 sunyc. All rights reserved.
//

import UIKit
import JVFloatingDrawer

class MainNavController: JVFloatingDrawerViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.leftViewController = self.storyboard?.instantiateViewController(withIdentifier: "leftvc")
        self.centerViewController = self.storyboard?.instantiateViewController(withIdentifier: "centervc")
        self.leftDrawerWidth = 240
        self.backgroundImage = UIImage(named: "back")
        self.animator = JVFloatingDrawerSpringAnimator()
    }

}
