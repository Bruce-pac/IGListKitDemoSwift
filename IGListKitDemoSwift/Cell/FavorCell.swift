//
//  FavorCell.swift
//  IGListKitDemoSwift
//
//  Created by gxy on 2018/9/29.
//  Copyright © 2018年 bruce. All rights reserved.
//

import UIKit
import IGListKit

class FavorCell: UICollectionViewCell {
    @IBOutlet weak var favorBtn: UIButton!
    @IBOutlet weak var nameLabel: UILabel!

    var favorOperation: ((FavorCell) -> Void)?

    var viewModel: FavorCellModel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func onClickFavor(_ sender: Any) {
        self.favorOperation!(self)
    }
    
}

extension FavorCell: ListBindable {
    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? FavorCellModel else { return }
        self.viewModel = viewModel
        self.favorBtn.isSelected = viewModel.isFavor
        self.nameLabel.text = viewModel.favorNum
    }
}
