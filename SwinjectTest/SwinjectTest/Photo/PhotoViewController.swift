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
        $0.textColor = UIColor.init(rgb: 0xD0E0E3)
        $0.font = UIFont(name: MyFont.APPLE_COLOR_EMOJI, size: 30)
    }
    
    private let testButton = UIButton().then {
        $0.setTitle("연결 테스트", for: .normal)
        $0.setTitleColor(.red, for: .normal)
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
        
        view.addSubview(testButton)
        testButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-50)
            make.height.equalTo(30)
            make.width.equalTo(100)
        }
    }
    
    func bind(reactor: PhotoReactor) {
        reactor.state.map { $0.query }
        .bind(to: titleLabel.rx.text)
        .disposed(by: disposeBag)
        
        testButton.rx.tap
            .map { PhotoReactor.Action.searchButtonTapped }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }

}
