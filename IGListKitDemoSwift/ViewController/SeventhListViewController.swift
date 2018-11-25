//
//  SeventhListViewController.swift
//  IGListKitDemoSwift
//
//  Created by gxy on 2018/11/25.
//  Copyright © 2018年 bruce. All rights reserved.
//

import Foundation
import IGListKit

class SeventhListViewController: BaseListViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            let data = try JsonTool.decode([Feed].self, jsonfileName: "data4")
            self.objects.append(contentsOf: data)
            adapter.performUpdates(animated: true, completion: nil)
        } catch {
            print("decode failure")
        }
    }

    override func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        let stack = FeedBindingSectionController()
        stack.inset = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        return stack
    }
}
