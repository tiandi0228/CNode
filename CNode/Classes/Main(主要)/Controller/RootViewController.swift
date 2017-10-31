//
//  RootViewController.swift
//  CNode
//
//  Created by sunyuchun on 2017/10/29.
//  Copyright © 2017年 sunyc. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    // 主页导航控制器
    var mainNavigationController: UINavigationController!
    // 主页面控制器
    var mainViewController: MainTableViewController!
    // 左侧菜单控制器
    var menuViewController: MenuViewController!
    // 遮罩
    var maskView: UIView!
    
    static let shareDrawer = UIApplication.shared.keyWindow?.rootViewController as? RootViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 添加获取到的视图控制器的视图
        mainNavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainNavigationController") as! UINavigationController
        view.addSubview(mainNavigationController.view)
        //添加子视图控制器
        addChildViewController(mainNavigationController)
        mainNavigationController.didMove(toParentViewController: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // 展开左侧菜单
    func openMenu() {
        menuViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuViewController") as UIViewController as! MenuViewController
        view.addSubview(menuViewController.view)
        menuViewController.view.frame.origin.x = 0
        menuViewController.view.center.y = self.view.center.y
        maskView = UIView(frame: view.frame.offsetBy(dx: 0, dy: 0))
        maskView.backgroundColor = UIColor.black
        view.addSubview(maskView)
        maskView.alpha = 0.5
        UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions(), animations: { () -> Void in
            self.mainNavigationController.view.frame.origin.x = UIScreen.main.bounds.width - 50
            self.maskView.frame.origin.x = UIScreen.main.bounds.width - 50
        }, completion: nil)
    }
}
