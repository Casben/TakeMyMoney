//
//  PayPalSignInTableVC.swift
//  TakeMyMoney
//
//  Created by Herbert Dodge on 4/17/21.
//

import UIKit

class PaymentSelectionTableVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
        tableView.layer.cornerRadius = 20
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

}
