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
    
    // 左侧菜单
    var menuViewController: MenuViewController!
    
    // 屏幕高度
    var height = UIScreen.main.bounds.height
    var distance: CGFloat = 0
    let FullDistance: CGFloat = 0.78
    let Proportion: CGFloat = 0.77
    var centerOfLeftViewAtBeginning: CGPoint!
    var proportionOfLeftView: CGFloat = 1
    var distanceOfLeftView: CGFloat = 50
    
    // 侧滑菜单黑色半透明遮罩层
    var blackCover: UIView!
    
    static let shareDrawer = UIApplication.shared.keyWindow?.rootViewController as? RootViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 初始化主视图
        mainNavigationController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "MainNavigationController")
            as! UINavigationController
        view.addSubview(mainNavigationController.view)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func openMenu() {
        // 给首页 加入 点击自动关闭侧滑菜单功能
//        mainNavigationController.addGestureRecognizer(tapGesture)
        // 计算距离，执行菜单自动滑动动画
        distance = self.view.center.x * (FullDistance*2 + Proportion - 1)
        doTheAnimate(self.Proportion, showWhat: "left")
        // 执行视差特效
        blackCover.alpha = (Proportion - Proportion) / (1 - Proportion)
        // 执行左视图动画
        let pro = 0.8 + (proportionOfLeftView - 0.8) * Proportion
        menuViewController.view.transform = CGAffineTransform.identity.scaledBy(x: pro, y: pro)
    }
    
    func closeMenu() {

    }
    
    // 执行动画：显示左侧菜单、显示主页
    func doTheAnimate(_ proportion: CGFloat, showWhat: String) {
        UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions(), animations: { () -> Void in
            self.mainNavigationController.view.center = CGPoint(x: self.view.center.x + self.distance, y: self.view.center.y)
            self.mainNavigationController.view.transform = CGAffineTransform.identity.scaledBy(x: proportion, y: proportion)
            // 在侧滑菜单之上增加黑色遮罩层，目的是实现视差特效
            self.blackCover = UIView(frame: self.view.frame.offsetBy(dx: 0, dy: 0))
            self.blackCover.backgroundColor = UIColor.black
            self.view.addSubview(self.blackCover)
            if showWhat == "left" {
                // 通过 StoryBoard 取出左侧侧滑菜单视图
                self.menuViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
                self.view.addSubview(self.menuViewController.view)
                self.menuViewController.view.center = CGPoint(x: self.distanceOfLeftView, y: self.menuViewController.view.center.y)
                // 缩放左侧菜单
                self.menuViewController.view.transform = CGAffineTransform.identity.scaledBy(x: self.proportionOfLeftView, y: self.proportionOfLeftView)
            }
            // 改变黑色遮罩层的透明度，实现视差效果
            self.blackCover.alpha = showWhat == "home" ? 1 : 0
            
        }, completion: nil)
    }
}
