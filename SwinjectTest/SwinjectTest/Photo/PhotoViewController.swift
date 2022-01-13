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

class PhotoViewController: BaseViewController, View {
    
    var disposeBag: DisposeBag = DisposeBag()
    
    private let titleLabel = UILabel().then {
        $0.text = "Title"
        $0.textColor = MyColor.TestColor
        $0.font = UIFont(name: MyFont.APPLE_COLOR_EMOJI, size: 30)
    }
    
    private let testButton = UIButton().then {
        $0.setTitle("연결 테스트", for: .normal)
        $0.setTitleColor(.red, for: .normal)
    }
    
    private let searchController = UISearchController(searchResultsController: nil).then {
        $0.searchBar.placeholder = "사진을 검색하세요."
        $0.hidesNavigationBarDuringPresentation = false
    }
    
    private let photoCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeConstraints()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        self.navigationItem.searchController = searchController
        self.navigationItem.title = "Search"
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func makeConstraints() {
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
