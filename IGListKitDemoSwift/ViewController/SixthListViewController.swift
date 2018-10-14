//
//  SixthListViewController.swift
//  IGListKitDemoSwift
//
//  Created by gxy on 2018/10/13.
//  Copyright © 2018年 bruce. All rights reserved.
//

import Foundation
import IGListKit

class SixthListViewController: BaseListViewController {

    var token: NSObjectProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            let data = try JsonTool.decode([Feed].self, jsonfileName: "data4")
            self.objects.append(contentsOf: data)
            adapter.performUpdates(animated: true, completion: nil)
        } catch {
            print("decode failure")
        }
        token = NotificationCenter.default.addObserver(forName: Notification.Name.custom.delete, object: nil, queue: OperationQueue.main) {[weak self] (noti) in
            guard let object = noti.object as? Feed,let self = self else {
                return
            }
            self.objects.removeAll { (element) -> Bool in
                guard let ele = element as? Feed else {
                    return false
                }
                return ele == object
            }
            self.adapter.performUpdates(animated: true, completion: nil)
        }

    }

    override func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        switch object {
        case is Feed:
            return FeedSectionController()
        default:
            fatalError()
        }
    }
}
