//
//  AFDemosVC.swift
//  AllDemosInOneDemo
//
//  Created by 刘智民 on 04/02/2018.
//  Copyright © 2018 刘智民. All rights reserved.
//

import UIKit

class AFDemosVC: UITableViewController {

    let afDemos = [["title":"afGet"],["title":"afPost"],["title":"afImage"]]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "afdemosCell")
        self.title = "AFDemos"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return afDemos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rxCellIdentifier = "afdemosCell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: rxCellIdentifier)
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: rxCellIdentifier)
        }
        cell?.textLabel?.text = afDemos[indexPath.row]["title"]
        return (cell)!
    }
    
    // MARK: - table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        var demoVC:UIViewController? = nil
        
        switch indexPath.row {
        case 0:
            demoVC = nil
            break
        case 1:
           
            break;
        default:
            break
        }
        if let vc = demoVC {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
