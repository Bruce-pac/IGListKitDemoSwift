//
//  ViewController.swift
//  IGListKitDemoSwift
//
//  Created by gxy on 2018/8/1.
//  Copyright © 2018年 bruce. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.navigationController?.pushViewController(FirstListViewController(), animated: true)
        case 1:
            self.navigationController?.pushViewController(SecondListViewController(), animated: true)
        case 2:
            self.navigationController?.pushViewController(ThirdListViewController(), animated: true)
        case 3:
            self.navigationController?.pushViewController(ForthListViewController(), animated: true)
        case 4:
            self.navigationController?.pushViewController(FifthListViewController(), animated: true)
        case 5:
            self.navigationController?.pushViewController(SixthListViewController(), animated: true)
        case 6:
            self.navigationController?.pushViewController(SeventhListViewController(), animated: true)
        default:
            fatalError()
        }
    }


}

