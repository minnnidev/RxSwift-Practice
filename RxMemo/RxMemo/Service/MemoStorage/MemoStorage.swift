//
//  MemoStorage.swift
//  RxMemo
//
//  Created by 김민 on 5/8/24.
//

import Foundation
import RxSwift

class MemoStorage: MemoStorageType {
    
    private var list = [
        Memo(content: "hello", insertDate: Date().addingTimeInterval(-10)),
        Memo(content: "hi", insertDate: Date().addingTimeInterval(-20))
    ]

    private lazy var sectionModel = MemoSectionModel(model: 0, items: list)
    private lazy var store = BehaviorSubject<[MemoSectionModel]>(value: [sectionModel])

    @discardableResult
    func createMemo(content: String) -> Observable<Memo> {
        let memo = Memo(content: content)
        sectionModel.items.insert(memo, at: 0)

        store.onNext([sectionModel])

        return Observable.just(memo)
    }

    @discardableResult
    func memoList() -> Observable<[MemoSectionModel]> {
        return store
    }

    @discardableResult
    func update(memo: Memo, content: String) -> Observable<Memo> {
        let updatedMemo = Memo(origin: memo, updatedContent: content)

        if let index = sectionModel.items.firstIndex(where: { $0 == memo }) {
            sectionModel.items.remove(at: index)
            sectionModel.items.insert(updatedMemo, at: index)
        }

        store.onNext([sectionModel])

        return Observable.just(updatedMemo)
    }

    @discardableResult
    func delete(memo: Memo) -> Observable<Memo> {
        if let index = sectionModel.items.firstIndex(where: { $0 == memo }) {
            sectionModel.items.remove(at: index)
        }

        store.onNext([sectionModel])

        return Observable.just(memo)
    }
}

