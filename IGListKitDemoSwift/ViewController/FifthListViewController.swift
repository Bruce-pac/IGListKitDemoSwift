//
//  FifthListViewController.swift
//  IGListKitDemoSwift
//
//  Created by gxy on 2018/9/13.
//  Copyright © 2018年 bruce. All rights reserved.
//

import UIKit
import IGListKit

class FifthListViewController: BaseListViewController {

    var token: NSObjectProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            let data = try JsonTool.decode([DataType<Feed,Ad>].self, jsonfileName: "data5")
            let result = data.map { (data) -> ListDiffable in
                return data.value()
            }

            self.objects.append(contentsOf: result)
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
            let stack = ListStackedSectionController(sectionControllers:
                [UserInfoSectionController(),
                 ContentSectionController(),
                 ImageSectionController(),
                 FavorSectionController(),
                 CommentSectionController()])
            stack.inset = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
            return stack
        case is Ad:
            return AdSectionController()
        default:
            fatalError()
        }
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
