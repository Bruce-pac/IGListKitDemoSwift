//
//  CommentCell.swift
//  IGListKitDemoSwift
//
//  Created by gxy on 2018/10/6.
//  Copyright © 2018年 bruce. All rights reserved.
//

import UIKit
import IGListKit

class CommentCell: UICollectionViewCell {
    @IBOutlet weak var textLabel: UILabel!

    var viewModel: CommentCellModel?


    public var onClickDelete: ((CommentCell) -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction private func onClickDelete(_ sender: Any) {
        onClickDelete?(self)
    }
}

extension CommentCell: ListBindable {
    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? CommentCellModel else { return }
        self.viewModel = viewModel
        textLabel.attributedText = viewModel.commentStr
    }
}
