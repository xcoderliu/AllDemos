//
//  RxLoginVC.swift
//  RxSwiftDemo
//
//  Created by 刘智民 on 30/01/2018.
//  keys:缺省形参 尾随闭包 默认形参
//  Copyright © 2018 刘智民. All rights reserved.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

class RxLoginVC: UIViewController {
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UI
    func setUpViews() {
        self.title = "rxSwift login demo"
        self.view.backgroundColor = UIColor.white
        let userName = getTextObservable(name: "userName",otherViews: nil) { (tf:UITextField,views:[UIView?])  in
            tf.snp.makeConstraints({ (make) in
                make.width.equalTo(220)
                make.height.equalTo(40)
                make.top.equalTo(100)
                make.centerX.equalTo(self.view)
            })
            tf.borderStyle = .line
        }
        userName.subscribe(onNext: { (text) in
            print("username:\(String(describing: text))")
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        
        //可以对比看 let userName 写法其中是有差别的 上面的写法叫做尾随闭包
        //尾随闭包就是这个函数的最后一个参数是一个闭包，
        //所以规定这个闭包既可以写在函数的参数括号里面，也可以直接放在最后面来使用
        let userPwd = getTextObservable(name: "password", otherViews: self.view,self.view.subviews[0] ,setUI: { (tf:UITextField,views:[UIView?])  in
            tf.snp.makeConstraints({ (make) in
                make.width.equalTo(220)
                make.height.equalTo(40)
                make.centerX.equalTo(views[0]!)
                make.top.equalTo(views[1]!.snp.bottom).offset(20)
            })
            tf.isSecureTextEntry = true
            tf.borderStyle = .line
        })
        
        userPwd.subscribe(onNext: { (text) in
            print("password:\(String(describing: text))")
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        
        let userNameValid = userName
            .map {
                $0.count > 0
            }.share(replay: 1)
        userNameValid.subscribe(onNext: { (valid) in
            print("userNameValid:\(valid)")
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        
        let userPwdValid = userPwd
            .map {
                $0.count > 5
            }.share(replay: 1)
        userPwdValid.subscribe(onNext: { (valid) in
            print("userPwdValid:\(valid)")
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        
       let userNamePwdValid = Observable.combineLatest(userNameValid,userPwdValid){
            $0 && $1
        }.share(replay: 1)
        
        userNamePwdValid.subscribe(onNext: { (valid) in
            
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        
        let validLabel = UILabel()
        validLabel.textAlignment = .center
        self.view.addSubview(validLabel)
        validLabel.snp.makeConstraints { (make) in
            make.top.equalTo(220)
            make.width.equalTo(200)
            make.height.equalTo(40)
            make.centerX.equalTo(self.view)
        }
        
        let userNamePwdValidText = userNamePwdValid.map { (valid) -> String in
            return valid ? "有效的输入":"无效的输入"
        }
        
        userNamePwdValidText.bind(to: validLabel.rx.text).disposed(by: disposeBag)
    }
    
    //可以看到 swift默认形参可以不用掉队尾🙄 缺省形参也不用掉队尾了😂 缺省形参可以看作是用数组的方式
    func getTextObservable( name:String = "🐉", otherViews:UIView?..., setUI:(_ tf:UITextField , _ Views:[UIView?])->Void) -> ControlProperty<String> {
        let edit = UITextField()
        self.view.addSubview(edit)
        edit.placeholder = name
        setUI(edit,otherViews)
        return edit.rx.text.orEmpty
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
