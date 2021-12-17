//
//  BaseViewController.swift
//  Reciplease
//
//  Created by Greg on 26/11/2021.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
    }
    
    func configureNavigationBar() {
        navigationItem.title = LocalizedString.appTitle
        navigationItem.backButtonTitle = LocalizedString.backButtonTitle
    }
}
