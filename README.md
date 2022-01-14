# SwinjectTest

## 프로젝트 개요 및 목적
* 개요 : 사진 검색 & 자세히 보기 기능 구현
* 목적 : 아래 기술들을 함께 사용하면서, 각 기술들의 기능 및 조합을 테스트하는 프로젝트

### Test Skills
* RxSwift
* RxCocoa + RxDataSources + ReusableKit
* Swinject + Coordinator
* Alamofire -> ReactorKit
* SnapKit + Then
* Kingfisher

## 프로젝트 결과

### 앱 흐름도 및 구현 화면
|앱 흐름도|구현 화면|
|:-:|:-:|
|![First Image](https://images.pexels.com/photos/585759/pexels-photo-585759.jpeg?h=750&w=1260)|![Second Image](https://images.pexels.com/photos/1335115/pexels-photo-1335115.jpeg?h=750&w=1260)|

### 테스트 
#### RxCocoa와 RxDataSources, ReusableKit을 함께 사용해보기
* collectionView 적용기 : UnsplashAPI를 통해서 받아오는 데이터를 RxDataSources에서 사용할 데이터로 파싱, DataSource를 만들어, ReusableCell을 통해 collectionView에 적용

```swift
// 데이터 파싱
self.unsplashAPI.search(query)
    .map { [SectionModel<Int, Photo>.init(model: 0, items: $0)] }

// ReusableKit register 사용
private lazy var photoCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout).then {
    $0.register(Reusable.photoCell)
}

// 사용될 ReusableCell 선언
enum Reusable {
    static let photoCell = ReusableCell<PhotoCollectionViewCell>()
}

// datasource 제작 + resuablecell 사용
func createDataSources() -> RxCollectionViewSectionedReloadDataSource<SectionModel<Int, Photo>> {
    return RxCollectionViewSectionedReloadDataSource<SectionModel<Int, Photo>>.init { datasource, collectionView, indexPath, item in
        let cell = collectionView.dequeue(Reusable.photoCell, for: indexPath)
        cell.rendering(photo: item)
        return cell
    }
}

// reactor에서 받아온 데이터를 dataSource와 연동
reactor.state.map { $0.photoSections }
    .bind(to: photoCollectionView.rx.items(dataSource: createDataSources()))
    .disposed(by: disposeBag)
```

#### Swinject와 Coordinator 사이의 역할 관계 테스트
* Swinject에서는 의존성만 관리하고 Coordinator는 화면 전환에서 일어나는 데이터 전송을 담당
* Coordinator 사이에는 의존성 주입이 자연스럽게 일어나기 때문에 굳이 Swinject로 의존성 관리하지 X
* Assembly를 사용하여 각 의존성을 모듈화하고 Coordinator와 패턴을 맞춰 구조의 단조로움 추구
```swift
// 하나의 navigation과 assembler를 모든 코디네이터에 전달
class AppCoordinator: CoordinatorType {
    var assembler: Assembler
    var navigationController: UINavigationController = UINavigationController()
    init(assembler: Assembler, navigationController: UINavigationController) {
        self.assembler = assembler
        self.navigationController = navigationController
    }
    func start() {
        // coordinator는 assembler의 resolve로 인스턴스를 생성하지 않음
        let photoCoordinator = PhotoCoordinator(
            assembler: self.assembler,
            navigationController: self.navigationController)
        photoCoordinator.start()
    }
}

class PhotoCoordinator: CoordinatorType {

    //...

    // AppAssembler로 원하는 ViewController를 resolve
    // 이후에 데이터는 rendering 메서드를 통해서 전달 및 뷰 관련 업데이트 진행
    func navigatePhotoDetail(photo: Photo) {
        let photoDetailViewController = self.assembler.resolver.resolve(PhotoDetailViewController.self)!
        photoDetailViewController.rendering(photo: photo)
        navigationController.pushViewController(photoDetailViewController, animated: true)
    }
}

class PhotoAssembly: Assembly {
    func assemble(container: Container) {
        // resolve시 thread safe를 위해 synchronize 선언
        let safeResolver = container.synchronize()
        
        //...

        // 의존성 관리
        container.register(PhotoViewController.self) { resolver in
            let photoReactor = safeResolver.resolve(PhotoReactor.self)!
            let photoVC = PhotoViewController()
            photoVC.reactor = photoReactor
            return photoVC
        }

        // 의존성만 관리하고 데이터 전달하지 않음. 이 부부은 Coordinator에게 전담 
        container.register(PhotoDetailViewController.self, name: nil) { resolver in
            let photoDetailVC = PhotoDetailViewController()
            return photoDetailVC
        }
    }
}
```

#### Alamofire advanced
* URLRequestConvertible와 Router를 조합해 원하는 urlRequest를 간편하게 구현
```swift
// RouterType을 구현하고
protocol RouterType: URLRequestConvertible {
    var baseURLString: String { get }
    var path: String { get }
    var headers: HTTPHeaders? { get }
    var httpMethod: HTTPMethod { get }
    var parameters: RequestParams { get }
}

// extension을 통해 URLRequestConvertible의 asURLRequest을 구현해 자동으로 request 생성
// 필요한 추가 작업(공통 파라미터 등)은 Interceptor의 adaptor에서
extension RouterType {
    func asURLRequest() throws -> URLRequest {
        //...
    }
}

// 라우터를 통해 원하는 작업을 열겨형과 연관값으로 표현
enum MyRouter: RouterType {
    case searchPhoto(String)
    // ...
}

// 간단하게 사용가능
SessionManager
    .shared
    .session
    .request(MyRouter.searchPhoto(query))
    .validate(statusCode: 200...300)
    .response { response in
        // ...
    }
```

