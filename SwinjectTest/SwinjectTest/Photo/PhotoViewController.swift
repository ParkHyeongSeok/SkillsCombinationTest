//
//  PhotoViewController.swift
//  SwinjectTest
//
//  Created by 박형석 on 2022/01/12.
//

import UIKit
import ReactorKit
import ReusableKit
import RxDataSources
import RxSwift
import RxCocoa
import SnapKit
import Then

class PhotoViewController: BaseViewController, View {
    
    private let searchController = UISearchController(searchResultsController: nil).then {
        $0.searchBar.placeholder = "사진을 검색하세요."
        $0.hidesNavigationBarDuringPresentation = false
    }
    
    private let flowLayout = UICollectionViewFlowLayout().then {
        $0.minimumInteritemSpacing = 2
        $0.minimumLineSpacing = 2
        $0.scrollDirection = .vertical
    }
    
    private lazy var photoCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout).then {
        $0.register(Reusable.photoCell)
    }
    
    private let loadingView = UIActivityIndicatorView().then {
        $0.hidesWhenStopped = true
    }
    
    var disposeBag: DisposeBag = DisposeBag()
    var coordinator: PhotoCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeConstraints()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        self.navigationItem.searchController = searchController
        self.navigationItem.title = "Search Photo"
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func makeConstraints() {
        view.addSubview(photoCollectionView)
        photoCollectionView.snp.makeConstraints { make in
            make.top.left.bottom.right.equalToSuperview()
        }
        
        view.addSubview(loadingView)
        loadingView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func bind(reactor: PhotoReactor) {
        
        reactor.state.map { $0.photoSections }
        .bind(to: photoCollectionView.rx.items(dataSource: createDataSources()))
        .disposed(by: disposeBag)
        
        reactor.state.map { $0.isLoding }
        .bind(to: loadingView.rx.isAnimating)
        .disposed(by: disposeBag)
        
        searchController.searchBar.rx.text.orEmpty
            .map { PhotoReactor.Action.inputQuery($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        searchController.searchBar.rx.searchButtonClicked
            .map { PhotoReactor.Action.searchButtonTapped }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        Observable.zip(
            photoCollectionView.rx.itemSelected,
            photoCollectionView.rx.modelSelected(Photo.self))
            .bind(onNext: { [weak self] (indexPath, photo) in
                self?.photoCollectionView.deselectItem(at: indexPath, animated: false)
                if let coordinator = self?.coordinator {
                    coordinator.navigatePhotoDetail(photo: photo)
                }
            })
            .disposed(by: disposeBag)
        
        photoCollectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    func createDataSources() -> RxCollectionViewSectionedReloadDataSource<SectionModel<Int, Photo>> {
        return RxCollectionViewSectionedReloadDataSource<SectionModel<Int, Photo>>.init { datasource, collectionView, indexPath, item in
            let cell = collectionView.dequeue(Reusable.photoCell, for: indexPath)
            cell.rendering(photo: item)
            return cell
        }
    }
    
    enum Reusable {
        static let photoCell = ReusableCell<PhotoCollectionViewCell>()
    }

}

extension PhotoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let space: CGFloat = 2
        let width: CGFloat = (view.bounds.width - (space*2))/3
        let height: CGFloat = width
        return CGSize(width: width, height: height)
    }
}
