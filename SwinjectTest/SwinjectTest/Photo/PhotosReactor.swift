//
//  PhotoReactor.swift
//  UnsplashToyProject
//
//  Created by 박형석 on 2021/12/04.
//

import Foundation
import ReactorKit
import RxSwift
import RxCocoa
import Differentiator

class PhotoReactor: Reactor {
    
    enum Action {
        case inputQuery(String)
        case searchButtonTapped
    }
    
    enum Mutation {
        case setQuery(String)
        case setPhotoSection([SectionModel<Int, Photo>])
        case setIsLoading(Bool)
    }
    
    struct State {
        var query = "car"
        var photoSections = [SectionModel<Int, Photo>]()
        var isLoding = false
    }
    
    var initialState: State
    let unsplashAPI: UnsplashAPIType
    
    init(unsplashAPI: UnsplashAPIType) {
        self.unsplashAPI = unsplashAPI
        self.initialState = State()
    }
    
    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        return Observable.merge(mutation)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .inputQuery(let text):
            return Observable.just(.setQuery(text))
        case .searchButtonTapped:
            let query = self.currentState.query
            return self.unsplashAPI.search(query)
                .map { [SectionModel<Int, Photo>.init(model: 1, items: $0)] }
                .map { .setPhotoSection($0) }
                .debug()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setPhotoSection(let section):
            newState.photoSections = section
        case .setIsLoading(let isLoading):
            newState.isLoding = isLoading
        case .setQuery(let query):
            newState.query = query
        }
        return newState
    }
    
    private func fetchPhotos(query: String) -> Observable<[Photo]> {
        return Observable.just([])
    }
    
    
    
}
