//
//  ImageCollectionCell.swift
//  IGListKitDemoSwift
//
//  Created by gxy on 2018/10/5.
//  Copyright © 2018年 bruce. All rights reserved.
//

import UIKit
import IGListKit

class ImageCollectionCell: UICollectionViewCell {

    let padding: CGFloat = 10

    @IBOutlet weak var collectionView: UICollectionView!

    var viewModel: ImagesCollectionCellModel!

    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib(nibName: ImageCell.cellIdentifier, bundle: nil), forCellWithReuseIdentifier: ImageCell.cellIdentifier)
    }

}

extension ImageCollectionCell: ListBindable {
    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? ImagesCollectionCellModel else { return }
        self.viewModel = viewModel
        collectionView.reloadData()
    }
}

extension ImageCollectionCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.viewModel?.images.count)!
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.cellIdentifier, for: indexPath) as? ImageCell else { fatalError() }
        cell.image = self.viewModel?.images[indexPath.item]
        return cell
    }
}

extension ImageCollectionCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (collectionView.bounds.width - padding * 2) / 3
        return CGSize(width: width, height: width)
    }
}
