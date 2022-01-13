//
//  BaseViewController.swift
//  SwinjectTest
//
//  Created by 박형석 on 2022/01/13.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(showErrorPopup), name: NSNotification.Name("statusCode"), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("statusCode"), object: nil)
    }
    
    @objc func showErrorPopup(_ notification: Notification) {
        let statusCode = notification.object as! Int
        if !(200..<300).contains(statusCode) {
            print(String(describing: statusCode))
        }
    }

}
