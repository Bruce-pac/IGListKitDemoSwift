//
//  ThirdListViewController.swift
//  IGListKitDemoSwift
//
//  Created by gxy on 2018/9/13.
//  Copyright © 2018年 bruce. All rights reserved.
//

import UIKit
import IGListKit

class ThirdListViewController: BaseListViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            let data = try JsonTool.decode([Feed].self, jsonfileName: "data3")
            self.objects.append(contentsOf: data)
            adapter.performUpdates(animated: true, completion: nil)
        } catch {
            print("decode failure")
        }
    }

    override func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        let stack = ListStackedSectionController(sectionControllers:
            [UserInfoSectionController(),
             ContentSectionController(),
             ImageSectionController(),
             FavorSectionController()])
        stack.inset = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        return stack
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
