//
//  PhotoCollectionViewCell.swift
//  SwinjectTest
//
//  Created by 박형석 on 2022/01/13.
//

import UIKit
import SnapKit
import Then
import Kingfisher

class PhotoCollectionViewCell: UICollectionViewCell {
    static let identifier = "PhotoCollectionViewCell"
    
    private let photo = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        contentView.backgroundColor = .black
    }
    
    private func makeConstraints() {
        contentView.addSubview(photo)
        photo.snp.makeConstraints { make in
            make.top.left.bottom.right.equalToSuperview()
        }
    }
}

extension PhotoCollectionViewCell {
    func rendering(photo: Photo) {
        self.photo.kf.setImage(with: photo.image.url)
    }
}