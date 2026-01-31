//
//  ToastManager.swift
//  NetworkProjectDay20
//
//  Created by 김기태 on 1/31/26.
//

import UIKit
import Toast

class ToastManager {
    static func showToast(
        in viewController: UIViewController,
        message: String
    ) {
        viewController.view.makeToast(
            message,
            duration: 2.0,
            position: .center
        )
    }
}
