import UIKit
import RxSwift

/*
 <takeLast>
 원본 옵저버블의 마지막 count개의 이벤트만 방출
 */

let disposeBag = DisposeBag()

let subject = PublishSubject<Int>()

subject
    .takeLast(2)
    .subscribe { print($0) }
    .disposed(by: disposeBag)

(1...10).forEach { subject.onNext($0) }

subject.onNext(11)
// 출력되지 않음

//subject.onCompleted()
/*
 next(10)
 next(11)
 completed
 */

enum MyError: Error {
    case error
}

subject.onError(MyError.error)
// error(error)
// 에러를 전달하면 버퍼의 이벤트는 버리고 에러 이벤트만 전달
