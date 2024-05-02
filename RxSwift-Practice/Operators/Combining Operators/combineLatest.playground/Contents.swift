import UIKit
import RxSwift

/*
 <combineLatest>
 소스 옵저버블들이 방출하는 최신 요소를 결합
 */

let disposeBag = DisposeBag()

enum MyError: Error {
    case error
}

let greetings = PublishSubject<String>()
let languages = PublishSubject<String>()

Observable.combineLatest(greetings, languages) { lhs, rhs -> String in
    return "\(lhs) \(rhs)"
}
.subscribe { print($0) }
.disposed(by: disposeBag)

greetings.onNext("Hello")
// nothing
languages.onNext("World")
// next(Hello World)
greetings.onNext("Hi")
// next(Hi World)

//greetings.onError(MyError.error)
// error(error)
// 하나라도 에러 이벤트를 전달하면 구독자에게 에러 이벤트 전달

greetings.onCompleted()

languages.onNext("RxSwift")
// next(Hi RxSwift)

languages.onCompleted()
// 모든 구독자에게 completed 이벤트가 전달되면 completed 이벤트 구독자에게 전달
