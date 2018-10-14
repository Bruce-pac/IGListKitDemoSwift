//
//  AdCell.swift
//  IGListKitDemoSwift
//
//  Created by gxy on 2018/10/6.
//  Copyright © 2018年 bruce. All rights reserved.
//

import UIKit

class AdCell: UICollectionViewCell {
   private let label: UILabel = {
    let label = UILabel(frame: .zero)
    label.textAlignment = NSTextAlignment.center
    label.autoresizingMask = [.flexibleWidth,.flexibleHeight]
    return label
    }()

    var adTitle: String = "" {
        didSet {
            label.text = adTitle
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(label)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = contentView.bounds
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
