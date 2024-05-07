//
//  Memo.swift
//  RxMemo
//
//  Created by 김민 on 5/7/24.
//

import Foundation

struct Memo: Equatable {
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
