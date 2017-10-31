//
//  MenuViewController.swift
//  CNode
//
//  Created by sunyuchun on 2017/10/29.
//  Copyright © 2017年 sunyc. All rights reserved.
//

import UIKit
import SnapKit

class MenuViewController: UITableViewController {
    
    var SCREEN_WIDTH = UIScreen.main.bounds.width
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.clear
        self.view.frame.size.width = SCREEN_WIDTH - 50
//        self.view.center.x = 0
//        self.view.center.y = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
