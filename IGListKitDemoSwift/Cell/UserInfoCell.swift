//
//  UserInfoCell.swift
//  IGListKitDemoSwift
//
//  Created by gxy on 2018/9/25.
//  Copyright © 2018年 bruce. All rights reserved.
//

import UIKit
import IGListKit

class UserInfoCell: UICollectionViewCell {

    @IBOutlet weak var avatarView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    public var onClickArrow: ((UserInfoCell) -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.avatarView.layer.cornerRadius = 12
    }
    
    @IBAction private func onClickArrow(_ sender: Any) {
        onClickArrow?(self)
    }
    
}

extension UserInfoCell: ListBindable {
    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? UserInfoCellModel else { return }
        self.avatarView.backgroundColor = UIColor.purple
        self.nameLabel.text = viewModel.userName
    }
}
