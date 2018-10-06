//
//  ContentCell.swift
//  IGListKitDemoSwift
//
//  Created by gxy on 2018/9/29.
//  Copyright © 2018年 bruce. All rights reserved.
//

import UIKit
import IGListKit

class ContentCell: UICollectionViewCell {
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
   static func lineHeight() -> CGFloat {
        return UIFont.systemFont(ofSize: 16).lineHeight
    }
   static func height(for text: NSString,limitwidth: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: 16)
        let size: CGSize = CGSize(width: limitwidth - 20, height: CGFloat.greatestFiniteMagnitude)
        let rect = text.boundingRect(with: size, options: [.usesFontLeading,.usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font:font], context: nil)
        return ceil(rect.height)
    }
}

extension ContentCell: ListBindable {
    func bindViewModel(_ viewModel: Any) {
        guard let vm = viewModel as? String else { return }
        self.label.text = vm
    }
}
