//
//  RxSwiftDemosVC.swift
//  AllDemosInOneDemo
//
//  Created by 刘智民 on 31/01/2018.
//  Copyright © 2018 刘智民. All rights reserved.
//

import UIKit

class RxSwiftDemosVC: UITableViewController {

    let rxDemos = [["title":"rxLoginDemo"],["title":"rxTableViewDemo"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "rxdemosCell")
        self.title = "RxSwiftDemos"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - table view source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rxDemos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rxCellIdentifier = "rxdemosCell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: rxCellIdentifier)
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: rxCellIdentifier)
        }
        cell?.textLabel?.text = rxDemos[indexPath.row]["title"]
        return (cell)!
    }
    
    // MARK: - table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        var demoVC:UIViewController? = nil
        
        switch indexPath.row {
        case 0:
            demoVC = RxLoginVC()
            break
        case 1:
            demoVC = RxTableVC()
            break;
        default:
            break
        }
        if let vc = demoVC {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
