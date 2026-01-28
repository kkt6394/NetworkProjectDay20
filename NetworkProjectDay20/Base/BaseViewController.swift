//
//  BaseViewController.swift
//  NetworkProjectDay20
//
//  Created by 김기태 on 1/26/26.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    func configureHierarchy() {}
    func configureLayout() {}
    func configureView() {}
}
