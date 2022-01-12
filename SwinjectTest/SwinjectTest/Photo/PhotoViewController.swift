//
//  PhotoViewController.swift
//  SwinjectTest
//
//  Created by 박형석 on 2022/01/12.
//

import UIKit
import ReactorKit
import RxSwift
import RxCocoa
import SnapKit
import Then

class PhotoViewController: UIViewController, View {
    
    var disposeBag: DisposeBag = DisposeBag()
    
    private let titleLabel = UILabel().then {
        $0.text = "Title"
        $0.font = UIFont(name: MyFont.APPLE_COLOR_EMOJI, size: 30)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeConstraints()
        configureUI()
    }
    
    func configureUI() {
        view.backgroundColor = .systemBackground
    }
    
    func makeConstraints() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    func bind(reactor: PhotoReactor) {
        
    }

}
