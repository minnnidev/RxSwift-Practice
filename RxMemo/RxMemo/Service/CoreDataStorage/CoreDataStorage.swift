//
//  CoreDataStorage.swift
//  RxMemo
//
//  Created by 김민 on 5/10/24.
//

import Foundation
import RxSwift
import RxCocoa
import CoreData
import RxCoreData

class CoreDataStorage: MemoStorageType {
    let modelName: String

    init(modelName: String) {
        self.modelName = modelName
    }

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: modelName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    private var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    @discardableResult
    func createMemo(content: String) -> Observable<Memo> {
        let memo = Memo(content: content)

        do {
            try mainContext.rx.update(memo)
            return Observable.just(memo)
        } catch {
            return Observable.error(error)
        }
    }
    
    @discardableResult
    func memoList() -> Observable<[MemoSectionModel]> {
        return mainContext.rx.entities(Memo.self, sortDescriptors: [NSSortDescriptor(key: "insertDate", ascending: false)])
        .map { result in [MemoSectionModel(model: 0, items: result)] }
    }
    
    @discardableResult
    func update(memo: Memo, content: String) -> Observable<Memo> {
        let updatedMemo = Memo(origin: memo, updatedContent: content)

        do {
            _ = try mainContext.rx.update(updatedMemo)
            return Observable.just(updatedMemo)
        } catch {
            return Observable.error(error)
        }
    }
    
    @discardableResult
    func delete(memo: Memo) ->Observable<Memo> {
        do {
            try mainContext.rx.delete(memo)
            return Observable.just(memo )
        } catch {
            return Observable.error(error)
        }
    }
}
