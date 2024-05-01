import UIKit
import RxSwift

enum CustomError: Error {
    case error
}

let disposeBag = DisposeBag()

let subject = PublishSubject<String>()
// 이벤트가 전달되면 즉시 구독자에게 전달
// publishSubject가 생성되는 시점 - 첫 번째 구독되는 시점 사이에 이벤트가 전달되면 사라짐

subject.onNext("hello")

subject.subscribe {
    print(">> 1", $0)
}
.disposed(by: disposeBag)

subject.onNext("hello2")

subject.subscribe {
    print(">> 2", $0)
}
.disposed(by: disposeBag)

subject.onNext("hello3")

//subject.onCompleted()
//
//subject.subscribe {
//    print(">> 3", $0)
//}
//.disposed(by: disposeBag)
//// >> 3 completed

subject.onError(CustomError.error)

subject.subscribe {
    print(">> 3", $0)
}
.disposed(by: disposeBag)
