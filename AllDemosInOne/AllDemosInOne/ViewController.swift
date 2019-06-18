//
//  ViewController.swift
//  RxSwiftDemo
//
//  Created by 刘智民 on 29/01/2018.
//  Copyright © 2018 刘智民. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Flutter

class ViewController: UITableViewController {
    
    let Demos = [["title":"RxSwift"],["title":"AFDemos"],["title":"Flutter"],["title":"FlutterUserInterface"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.tableFooterView = UIView()
        self.title = "AllDemos"
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
        return Demos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "AllDemosCell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: cellIdentifier)
        }
        cell?.textLabel?.text = Demos[indexPath.row]["title"]
        return (cell)!
    }
    
    // MARK: - table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        var demoVC:UIViewController? = nil
        
        switch indexPath.row {
        case 0:
            demoVC = RxSwiftDemosVC()
            break
        case 1:
            demoVC = AFDemosVC()
            break
        case 2:
            let flutterEngine = (UIApplication.shared.delegate as? AppDelegate)?.flutterEngine
            let flutterViewController = FlutterViewController(nibName: nil, bundle: nil)
            flutterViewController.setInitialRoute("flutterCount")
            flutterEngine?.run(withEntrypoint: nil)
            demoVC = flutterViewController
            break
        case 3:
            let flutterEngine = (UIApplication.shared.delegate as? AppDelegate)?.flutterEngine
            let flutterViewController = FlutterViewController(nibName: nil, bundle: nil)
            flutterViewController.setInitialRoute("flutterUserInterface")
            flutterEngine?.run(withEntrypoint: nil)
            demoVC = flutterViewController
        default:
            break
        }
        if let vc = demoVC {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

