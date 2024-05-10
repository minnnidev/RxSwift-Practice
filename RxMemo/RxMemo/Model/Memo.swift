//
//  Memo.swift
//  RxMemo
//
//  Created by 김민 on 5/8/24.
//

import Foundation
import RxDataSources
import CoreData
import RxCoreData

struct Memo: Equatable, IdentifiableType {
    var content: String
    var insertDate: Date // 생성한 날짜
    var identity: String // 매모 구별용

    init(content: String, insertDate: Date = Date()) {
        self.content = content
        self.insertDate = insertDate
        self.identity = "\(insertDate.timeIntervalSinceReferenceDate)"
    }

    init(origin: Memo, updatedContent: String) {
        self = origin
        self.content = updatedContent
    }
}

extension Memo: Persistable {
    static var entityName: String {
        return "Memo"
    }
    
    static var primaryAttributeName: String {
        return "identity"
    }

    init(entity: NSManagedObject) {
        content = entity.value(forKey: "content") as! String
        insertDate = entity.value(forKey: "insertDate") as! Date
        identity = "\(insertDate.timeIntervalSinceReferenceDate)"
    }

    func update(_ entity: NSManagedObject) {
        entity.setValue(content, forKey: "content")
        entity.setValue(insertDate, forKey: "insertDate")
        entity.setValue("\(insertDate.timeIntervalSinceReferenceDate)", forKey: "identity")

        do {
            try entity.managedObjectContext?.save()
        } catch {
            print(error)
        }
    }
}
