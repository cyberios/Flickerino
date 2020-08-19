//
//  TapeViewModel.swift
//  Flickerino
//
//  Created by Alexraag on 17.08.2020.
//  Copyright © 2020 Alexraag. All rights reserved.
//
import Foundation
import RxSwift
import RxCocoa
import Action

class TapeViewModel: BaseViewModel{
    var getSearchList: AnyObserver<TapeFlow>
    var tapAction: AnyObserver<TapeCell.ActionFlow>
    
    var refreshObserver: AnyObserver<Void>
    var isLoading: Driver<Bool>
    
    let searchListSubject = BehaviorRelay<[SearchListCellModel]>(value: [])
    var searchList: Observable<[SearchListCellModel]> {
        return searchListSubject.asObservable()
    }
    
    var filterList:Observable<TapeHeaderCellModel?>
    let FilterSubject = PublishSubject<Void>()
    
    let flow = TapeFlow()
    let searchQuery = BehaviorRelay<String>(value: "")
    
    // total photos found
    var count:String = ""
    
    func viewWillAppear(){
        searchListSubject.accept([])
        getSearchList.onNext(flow)
    }
    
    init(router:TapeRouterProtocol,
         service:SearchNetworkServiceProtocol = SearchNetworkService()) {
         
         let _getListSubject = PublishSubject<TapeFlow>()
         getSearchList = _getListSubject.asObserver()

         let _tapActionSubject = PublishSubject<TapeCell.ActionFlow>()
         tapAction = _tapActionSubject.asObserver()

         let getSearchList: Action<TapeFlow, SearchListResponce> = .init { [service] flow -> Observable<SearchListResponce> in
            var query = flow.searchQuery
            if (query == "") {
                query = "Bmw"
            }
            return service.search(text: query, page:flow.currentOffset)
         }

         isLoading = getSearchList.executing
            .asDriver(onErrorJustReturn: false)

         let _refreshSubject = PublishSubject<Void>()
         refreshObserver = _refreshSubject.asObserver()
        
         let _filterSubject = PublishSubject<TapeHeaderCellModel?>()
         filterList = _filterSubject.asObserver()
        
         super.init()

         _refreshSubject
             .asObservable()
             .subscribe(onNext: { [weak self] _ in
                 guard let self = self else { return }
                 self.getSearchList.onNext(self.flow)
             }).disposed(by: disposeBag)

         _tapActionSubject
             .asObservable()
             .subscribe(onNext: { event in
                 switch event {
                 case .didTapSelect(let id):
                     router.showDetails(with: id)
                 }
             })
             .disposed(by: disposeBag)

         _getListSubject
             .asObservable()
             .flatMapLatest { flow -> Observable<Event<SearchListResponce>> in
                 getSearchList.execute(flow).materialize()
         }
         .observeOn(MainScheduler.instance)
         .compactMap { [weak self] elements -> [SearchListCellModel]? in
                guard let self = self else { return [] }
                self.FilterSubject.onNext(())
                if let count = elements.element?.count{
                    self.count = count
                }
                return elements.element?.items.map{
                    SearchListCellModel.init(item: $0)
                }
              }
             .bind(to: searchListSubject)
             .disposed(by: disposeBag)

         getSearchList.errors
             .asObservable()
             .observeOn(MainScheduler.instance)
             .subscribe(onNext: {[router] error in
                 //router.showErrorMessage(ErrorManager.map(error))
             })
             .disposed(by: disposeBag)
        
        searchQuery
            .asObservable()
            .subscribe(onNext: {
                [weak self] query in
                guard let self = self, self.flow.searchQuery != query else  { return }
                self.searchListSubject.accept([])
                self.flow.searchQuery = query
                self.getSearchList.onNext(self.flow)
            })
            .disposed(by: disposeBag)
        
        _filterSubject.disposed(by: disposeBag)
        FilterSubject
            .asObservable()
            .subscribe(onNext: {
                [weak self] _ in
                guard let self = self else {
                    return 
                }
                _filterSubject.onNext(.init(title: "Объявлений: " + self.count, buttonTitle: "По умолчанию", count: 0, filterAction: {
                        [weak self] in
                        
                    }
                ))})
                
            .disposed(by:disposeBag)
    }
    
    
}

extension TapeViewModel: TapeViewModelProtocol{
    
}

protocol TapeViewModelProtocol:class {
    var getSearchList: AnyObserver<TapeFlow> { get }
    var tapAction: AnyObserver<TapeCell.ActionFlow> { get }
    var refreshObserver: AnyObserver<Void> { get }
    var isLoading: Driver<Bool> { get }
    var searchList: Observable<[SearchListCellModel]> { get }
    var searchQuery: BehaviorRelay<String> { get }
    var filterList:Observable<TapeHeaderCellModel?> { get }
    func viewWillAppear()
}
