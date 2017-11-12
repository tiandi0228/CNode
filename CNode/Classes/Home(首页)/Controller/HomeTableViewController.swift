//
//  HomeTableViewController.swift
//  CNode
//
//  Created by sunyuchun on 2017/11/8.
//  Copyright © 2017年 sunyc. All rights reserved.
//

import UIKit
import SnapKit
import SwiftyJSON
import Moya
import RxSwift

class HomeTableViewController: UITableViewController {
    
    var buttonsArray: NSMutableArray!
    @IBOutlet weak var TabsView: UIView!
    // 列表数据
    var topics:Array<JSON> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.Tabs()
        self.Data()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - 网络请求
    func Data() {
        Api.request(.topics(page: 1, tab: nil, limit: 10)) { result in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                let json = JSON(data!)
//                self.topics = json["data"].arrayValue
                self.topics.append(contentsOf: json["data"].arrayValue)
                
                // 刷新表格数据
                DispatchQueue.main.async{
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // MARK: - 顶部菜单
    func Tabs() {
        buttonsArray = NSMutableArray()
        let tabs: [String] = ["全部", "分享", "问答", "招聘", "测试"]
        // 统计数量
        let count = tabs.count
        // 算出平均宽度
        let WIDTH = Config.SCREEN_WIDTH / CGFloat(count)
        for i in stride(from: 0, to: count, by: 1) {
            let tabButton = UIButton.init(type: .system)
            tabButton.frame = CGRect(x: WIDTH * CGFloat(i), y: 0, width: WIDTH, height: 44)
            tabButton.tag = i
            tabButton.setTitle(tabs[i] as String, for: UIControlState.normal)
            tabButton.backgroundColor = UIColor(red: 89/255, green: 89/255, blue: 89/255, alpha: 1)
            tabButton.setTitleColor(UIColor.lightGray, for: .normal)
            tabButton.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
            tabButton.addTarget(self, action: #selector(onClickBtn(_:)), for: UIControlEvents.touchUpInside)
            TabsView.addSubview(tabButton)
            buttonsArray.add(tabButton)
        }
    }
    
    @objc func onClickBtn(_ button:UIButton) {
        let tab = button.title(for: .normal) as Any
        print(tab)
        for btt in buttonsArray {
            (btt as AnyObject).titleLabel?!.font = UIFont.systemFont(ofSize: 14.0)
            (btt as AnyObject).setTitleColor(UIColor.lightGray, for: .normal)
        }
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16.0)
            button.setTitleColor(UIColor.white, for: UIControlState.normal)
        }) {(Bool) -> Void in
            
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return topics.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeTableViewCell
        
        let topic = topics[indexPath.row]
        
        cell.nameLabel.text = topic["author"]["loginname"].string
        
        // 设置头像为圆形
        cell.avatarImageView.layer.cornerRadius = 15
        cell.avatarImageView.clipsToBounds = true
        // 标签
        cell.topLabel.text = topic["tab"].string
        // 标题
        cell.titleLabel.text = topic["title"].string
        // 回复数
        cell.replyCountLabel.text = topic["reply_count"].string
        // 浏览量
        cell.visitCountLabel.text = topic["visit_count"].string
        // 内容
        cell.contentLabel.text = topic["content"].string
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
