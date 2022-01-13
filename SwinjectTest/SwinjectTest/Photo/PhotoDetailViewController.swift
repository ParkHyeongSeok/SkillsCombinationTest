//
//  PhotoDetailViewController.swift
//  SwinjectTest
//
//  Created by 박형석 on 2022/01/14.
//

import UIKit
import SnapKit
import Then
import Kingfisher

class PhotoDetailViewController: UIViewController {
    
    private let photo = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    
    private let photoPinch = UIPinchGestureRecognizer(target: self, action: #selector(zoomInOut))

    override func viewDidLoad() {
        super.viewDidLoad()
        makeConstraints()
        makeGestureRecognizer()
    }
    
    private func makeConstraints() {
        view.addSubview(photo)
        photo.snp.makeConstraints { make in
            make.top.left.bottom.right.equalToSuperview()
        }
    }
    
    private func makeGestureRecognizer() {
        view.addGestureRecognizer(photoPinch)
    }
    
    @objc func zoomInOut(_ pinch: UIPinchGestureRecognizer) {
        self.photo.transform = self.photo.transform.scaledBy(x: pinch.scale, y: pinch.scale)
        pinch.scale = 1
    }

}

extension PhotoDetailViewController {
    func rendering(photo: Photo) {
        self.photo.kf.setImage(with: photo.image.url)
    }
}
