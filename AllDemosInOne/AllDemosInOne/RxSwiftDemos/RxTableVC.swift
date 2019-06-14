//
//  RxTableVC.swift
//  AllDemosInOneDemo
//
//  Created by 刘智民 on 03/02/2018.
//  keys: rxDriver rxTableView
//  Copyright © 2018 刘智民. All rights reserved.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

class xctableData {
    public var title:String = "xctitle"
    public var subtitle:String = "xcsubtitle"
}

class xcTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
       super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class tableViewModel {
    // MARK: private properties
    private let privateDataSource: BehaviorRelay<[xctableData]> = BehaviorRelay(value: [])
    private let disposeBag = DisposeBag()
    
    // MARK: Outputs
    public let dataSource: Observable<[xctableData]>
    
    init(addItemTap: Driver<Void>) {
        
        // 让外部的数据作为内部数据的可观察源
        self.dataSource = privateDataSource.asObservable()
        
        // 让 addButton tap 追加一个新的 "Item" drive可以参考 https://github.com/ReactiveX/RxSwift/blob/master/Documentation/Traits.md
        //drive 创建的意图是能够让你的代码驱动 UI 进行修改
        addItemTap.drive(onNext: { [unowned self] _ in
            let tableData = xctableData()
            tableData.title = "rxTitle"
            tableData.subtitle = "rxSubTitle"
            var newData = self.privateDataSource.value
            newData.append(tableData)
            self.privateDataSource.accept(newData)
        }).disposed(by: disposeBag)
    }
}

class RxTableVC: UITableViewController {
    private let disposeBag = DisposeBag()
    private let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
    private var viewModel: tableViewModel?
    let labTip = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        bindModels()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - SetUps
    
    func setUpViews() {
        title = "rxSwift UITableView demo"
        tableView.delegate = nil
        tableView.dataSource = nil
        tableView.tableFooterView = UIView()
        tableView.register(xcTableViewCell.self, forCellReuseIdentifier: "txTableVCCell")
        navigationItem.setRightBarButton(addButton, animated: true)
        labTip.text = "please tap the navigation bar item '+'"
        labTip.textAlignment = .center
        tableView.addSubview(labTip)
        labTip.snp.makeConstraints { [unowned self] (make) in
            make.centerX.equalTo(self.tableView)
            make.centerY.equalTo(self.tableView.snp.centerY).offset(-100)
            make.height.equalTo(20)
            make.width.equalTo(self.tableView ?? self.view)
        }
    }
    
    // MARK: - Bind model
    
    func bindModels() {
        viewModel = tableViewModel(addItemTap: addButton.rx.tap.asDriver())
        viewModel?.dataSource
            .bind(to: tableView.rx.items(cellIdentifier: "txTableVCCell", cellType: xcTableViewCell.self)) {  row, element, cell in
                cell.textLabel?.text = "\(element.title) \(row)"
                cell.detailTextLabel?.text = "\(element.subtitle) \(row)"
            }.disposed(by:disposeBag)
        viewModel?.dataSource.subscribe { [unowned self] (datas) in
            self.labTip.isHidden = datas.element?.count ?? 0 > 0
        }.disposed(by: disposeBag)
    }
}
